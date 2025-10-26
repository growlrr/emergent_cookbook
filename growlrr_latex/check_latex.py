#!/usr/bin/env python3
"""
LaTeX Pre-Compilation Checker
Checks for file references, missing files, and potential syntax issues
"""

import re
import os
from pathlib import Path

def extract_inputs(tex_file):
    """Extract all \input and \include commands from a tex file"""
    with open(tex_file, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
    
    # Match \input{filename} or \include{filename}
    pattern = r'\\(?:input|include)\{([^}]+)\}'
    matches = re.findall(pattern, content)
    return matches

def check_file_exists(base_path, ref_file):
    """Check if a referenced file exists (with or without .tex extension)"""
    # Try with .tex extension
    full_path = base_path / (ref_file if ref_file.endswith('.tex') else ref_file + '.tex')
    if full_path.exists():
        return True, str(full_path)
    
    # Try without .tex extension (in case it's already there)
    full_path = base_path / ref_file
    if full_path.exists():
        return True, str(full_path)
    
    return False, None

def main():
    base_dir = Path('/app/Emergent')
    main_tex = base_dir / 'main.tex'
    
    print("=" * 80)
    print("LaTeX Pre-Compilation Check")
    print("=" * 80)
    print()
    
    # Check main.tex exists
    if not main_tex.exists():
        print("❌ ERROR: main.tex not found!")
        return
    
    print("✓ main.tex found")
    
    # Check style file
    style_file = base_dir / 'growlrr_style.sty'
    if style_file.exists():
        print("✓ growlrr_style.sty found")
    else:
        print("❌ ERROR: growlrr_style.sty not found!")
    
    # Check bibliography file
    bib_file = base_dir / 'growlrr_bibliography.bib'
    if bib_file.exists():
        print("✓ growlrr_bibliography.bib found")
    else:
        print("❌ ERROR: growlrr_bibliography.bib not found!")
    
    print()
    print("-" * 80)
    print("Checking file references in main.tex...")
    print("-" * 80)
    
    # Extract all input references
    refs = extract_inputs(main_tex)
    print(f"\nFound {len(refs)} file references")
    print()
    
    missing_files = []
    found_files = []
    
    for ref in refs:
        exists, full_path = check_file_exists(base_dir, ref)
        if exists:
            found_files.append((ref, full_path))
            print(f"✓ {ref}")
        else:
            missing_files.append(ref)
            print(f"❌ MISSING: {ref}")
    
    print()
    print("-" * 80)
    print("Summary")
    print("-" * 80)
    print(f"Total references: {len(refs)}")
    print(f"Found: {len(found_files)}")
    print(f"Missing: {len(missing_files)}")
    
    if missing_files:
        print()
        print("Missing files:")
        for mf in missing_files:
            print(f"  - {mf}")
    
    print()
    print("-" * 80)
    print("Checking for common LaTeX issues...")
    print("-" * 80)
    
    # Check main.tex for common issues
    with open(main_tex, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Check for unclosed environments
    begin_count = len(re.findall(r'\\begin\{', content))
    end_count = len(re.findall(r'\\end\{', content))
    if begin_count == end_count:
        print(f"✓ Balanced \\begin/\\end pairs ({begin_count} each)")
    else:
        print(f"⚠ WARNING: Unbalanced \\begin/\\end (begin: {begin_count}, end: {end_count})")
    
    # Check for special characters that might cause issues
    if '&' in content and '\\&' not in content:
        ampersand_count = content.count('&') - content.count('\\&')
        print(f"⚠ Found {ampersand_count} unescaped '&' characters (may be in tables)")
    
    print()
    print("=" * 80)
    print("Pre-compilation check complete!")
    print("=" * 80)

if __name__ == '__main__':
    main()
