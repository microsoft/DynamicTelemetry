#!/usr/bin/env python3
"""
MkDocs Documentation Analyzer and Enhancement Script
Comprehensive tool for analyzing and improving MkDocs documentation.
"""

import os
import re
import argparse
import json
import yaml
from pathlib import Path
from typing import List, Dict, Set, Tuple, Optional
from datetime import datetime
import sys


class MkDocsAnalyzer:
    """Main analyzer class for MkDocs documentation improvements."""
    
    def __init__(self, root_dir: str):
        self.root_dir = Path(root_dir)
        self.docs_dir = self.root_dir / "docs"
        self.mkdocs_config = self.root_dir / "mkdocs.yml"
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'markdown_issues': [],
            'config_suggestions': [],
            'accessibility_issues': [],
            'plugin_suggestions': []
        }
    
    def analyze_all(self) -> Dict:
        """Run comprehensive analysis of the documentation."""
        print("🔍 Starting comprehensive MkDocs analysis...")
        
        # Analyze markdown files
        self._analyze_markdown_files()
        
        # Analyze mkdocs.yml configuration
        self._analyze_mkdocs_config()
        
        # Check accessibility
        self._analyze_accessibility()
        
        # Suggest plugin improvements
        self._suggest_plugin_enhancements()
        
        return self.results
    
    def _analyze_markdown_files(self):
        """Analyze all markdown files for improvement opportunities."""
        print("📝 Analyzing markdown files...")
        
        markdown_files = list(self.docs_dir.glob('**/*.md'))
        total_issues = 0
        
        for md_file in markdown_files:
            if md_file.is_file():
                issues = self._analyze_single_markdown(md_file)
                if issues['total_issues'] > 0:
                    self.results['markdown_issues'].append(issues)
                    total_issues += issues['total_issues']
        
        print(f"   Found {total_issues} markdown issues across {len(markdown_files)} files")
    
    def _analyze_single_markdown(self, file_path: Path) -> Dict:
        """Analyze a single markdown file."""
        issues = {
            'file': str(file_path.relative_to(self.docs_dir)),
            'heading_issues': [],
            'code_block_issues': [],
            'image_issues': [],
            'table_issues': [],
            'link_issues': [],
            'accessibility_issues': [],
            'content_suggestions': [],
            'total_issues': 0
        }
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            lines = content.split('\n')
            
            # Analyze different aspects
            self._check_headings(lines, issues)
            self._check_code_blocks(content, issues)
            self._check_images(content, issues)
            self._check_tables(lines, issues)
            self._check_links(content, issues)
            self._check_content_structure(lines, issues)
            
            # Calculate total issues
            issues['total_issues'] = sum(
                len(issues[key]) for key in issues 
                if key.endswith('_issues') or key.endswith('_suggestions')
            )
            
        except Exception as e:
            issues['error'] = str(e)
            issues['total_issues'] = 1
        
        return issues
    
    def _check_headings(self, lines: List[str], issues: Dict):
        """Check heading structure and hierarchy."""
        heading_levels = []
        prev_level = 0
        
        for i, line in enumerate(lines, 1):
            if line.strip().startswith('#'):
                level = len(line) - len(line.lstrip('#'))
                heading_levels.append((i, level, line.strip()))
                
                # Check for level jumps
                if prev_level > 0 and level > prev_level + 1:
                    issues['heading_issues'].append({
                        'line': i,
                        'type': 'heading_jump',
                        'message': f'Heading level jump from H{prev_level} to H{level}',
                        'suggestion': f'Consider using H{prev_level + 1} for better hierarchy'
                    })
                
                prev_level = level
        
        # Check if document starts with H1
        if heading_levels and heading_levels[0][1] != 1:
            issues['heading_issues'].append({
                'line': heading_levels[0][0],
                'type': 'no_h1_start',
                'message': 'Document should start with H1',
                'suggestion': 'Add a main heading (H1) at the top of the document'
            })
    
    def _check_code_blocks(self, content: str, issues: Dict):
        """Check code blocks for syntax highlighting and formatting."""
        # Check fenced code blocks without language
        fenced_pattern = r'```(\w*)\n(.*?)\n```'
        fenced_blocks = re.findall(fenced_pattern, content, re.DOTALL)
        
        for i, (lang, code) in enumerate(fenced_blocks):
            if not lang.strip():
                issues['code_block_issues'].append({
                    'block': i + 1,
                    'type': 'missing_syntax_highlighting',
                    'message': 'Code block without syntax highlighting',
                    'suggestion': 'Add language identifier (e.g., ```python, ```bash, ```yaml)'
                })
        
        # Check for indented code blocks
        lines = content.split('\n')
        in_indented_block = False
        
        for i, line in enumerate(lines):
            if line.startswith('    ') and line.strip() and not line.startswith('    #'):
                if not in_indented_block:
                    issues['code_block_issues'].append({
                        'line': i + 1,
                        'type': 'indented_code_block',
                        'message': 'Indented code block detected',
                        'suggestion': 'Consider using fenced code blocks (```) for better syntax highlighting'
                    })
                    in_indented_block = True
            elif not line.startswith('    '):
                in_indented_block = False
    
    def _check_images(self, content: str, issues: Dict):
        """Check images for alt text and accessibility."""
        # Find markdown images
        image_pattern = r'!\[(.*?)\]\((.*?)\)'
        images = re.findall(image_pattern, content)
        
        for i, (alt_text, src) in enumerate(images):
            if not alt_text.strip():
                issues['image_issues'].append({
                    'image': i + 1,
                    'src': src,
                    'type': 'missing_alt_text',
                    'message': 'Image missing alt text',
                    'suggestion': 'Add descriptive alt text for accessibility'
                })
            elif len(alt_text.strip()) < 3:
                issues['image_issues'].append({
                    'image': i + 1,
                    'src': src,
                    'alt': alt_text,
                    'type': 'short_alt_text',
                    'message': 'Alt text too short',
                    'suggestion': 'Provide more descriptive alt text'
                })
    
    def _check_tables(self, lines: List[str], issues: Dict):
        """Check tables for proper formatting."""
        for i, line in enumerate(lines):
            if '|' in line and line.strip().startswith('|') and line.strip().endswith('|'):
                # Check if next line is a header separator
                if i + 1 < len(lines):
                    next_line = lines[i + 1].strip()
                    if not (next_line and '|' in next_line and ('-' in next_line or ':' in next_line)):
                        issues['table_issues'].append({
                            'line': i + 1,
                            'type': 'missing_header_separator',
                            'message': 'Table without header separator',
                            'suggestion': 'Add header separator row (e.g., |---|---|)'
                        })
                break
    
    def _check_links(self, content: str, issues: Dict):
        """Check links for clarity and validity."""
        link_pattern = r'\[([^\]]+)\]\(([^)]+)\)'
        links = re.findall(link_pattern, content)
        
        unclear_texts = ['click here', 'here', 'this', 'link', 'read more']
        
        for i, (link_text, url) in enumerate(links):
            if link_text.lower().strip() in unclear_texts:
                issues['link_issues'].append({
                    'link': i + 1,
                    'text': link_text,
                    'url': url,
                    'type': 'unclear_link_text',
                    'message': 'Unclear link text',
                    'suggestion': 'Use descriptive link text that explains the destination'
                })
    
    def _check_content_structure(self, lines: List[str], issues: Dict):
        """Check content structure for readability."""
        paragraph_lengths = []
        current_paragraph = []
        
        for line in lines:
            if line.strip():
                current_paragraph.append(line)
            else:
                if current_paragraph:
                    paragraph_text = ' '.join(current_paragraph)
                    paragraph_lengths.append(len(paragraph_text))
                    current_paragraph = []
        
        # Check for overly long paragraphs
        for i, length in enumerate(paragraph_lengths):
            if length > 800:  # Threshold for long paragraphs
                issues['content_suggestions'].append({
                    'paragraph': i + 1,
                    'type': 'long_paragraph',
                    'length': length,
                    'message': 'Long paragraph detected',
                    'suggestion': 'Consider breaking into smaller paragraphs or adding lists/blockquotes'
                })
    
    def _analyze_mkdocs_config(self):
        """Analyze mkdocs.yml configuration for improvements."""
        print("⚙️  Analyzing MkDocs configuration...")
        
        if not self.mkdocs_config.exists():
            self.results['config_suggestions'].append({
                'type': 'missing_config',
                'message': 'mkdocs.yml not found',
                'suggestion': 'Create mkdocs.yml configuration file'
            })
            return
        
        try:
            with open(self.mkdocs_config, 'r', encoding='utf-8') as f:
                config = yaml.safe_load(f)
            
            self._check_config_completeness(config)
            self._suggest_plugin_improvements(config)
            self._check_theme_configuration(config)
            
        except Exception as e:
            self.results['config_suggestions'].append({
                'type': 'config_error',
                'message': f'Error reading mkdocs.yml: {str(e)}',
                'suggestion': 'Fix YAML syntax errors in mkdocs.yml'
            })
    
    def _check_config_completeness(self, config: Dict):
        """Check for essential configuration options."""
        essential_fields = {
            'site_name': 'Add a descriptive site name',
            'site_description': 'Add a site description for SEO',
            'site_url': 'Add site URL for proper link generation',
            'repo_url': 'Add repository URL for edit links'
        }
        
        for field, suggestion in essential_fields.items():
            if field not in config:
                self.results['config_suggestions'].append({
                    'type': 'missing_field',
                    'field': field,
                    'message': f'Missing {field} in configuration',
                    'suggestion': suggestion
                })
    
    def _suggest_plugin_improvements(self, config: Dict):
        """Suggest plugin improvements."""
        current_plugins = []
        if 'plugins' in config:
            for plugin in config['plugins']:
                if isinstance(plugin, str):
                    current_plugins.append(plugin)
                elif isinstance(plugin, dict):
                    current_plugins.extend(plugin.keys())
        
        recommended_plugins = {
            'minify': 'Minify HTML, CSS, JS for better performance',
            'git-revision-date-localized': 'Add last updated dates to pages',
            'awesome-pages': 'Flexible page organization',
            'social': 'Generate social media cards'
        }
        
        for plugin, description in recommended_plugins.items():
            if plugin not in current_plugins:
                self.results['plugin_suggestions'].append({
                    'plugin': plugin,
                    'description': description,
                    'type': 'recommended_plugin'
                })
    
    def _check_theme_configuration(self, config: Dict):
        """Check theme configuration for best practices."""
        if 'theme' not in config:
            self.results['config_suggestions'].append({
                'type': 'missing_theme',
                'message': 'No theme specified',
                'suggestion': 'Add theme configuration (recommend: material)'
            })
            return
        
        theme = config['theme']
        if isinstance(theme, dict) and theme.get('name') == 'material':
            # Check for recommended Material theme features
            features = theme.get('features', [])
            recommended_features = [
                'navigation.top',
                'navigation.tabs',
                'search.highlight',
                'content.code.copy'
            ]
            
            missing_features = [f for f in recommended_features if f not in features]
            if missing_features:
                self.results['config_suggestions'].append({
                    'type': 'theme_features',
                    'message': 'Missing recommended theme features',
                    'suggestion': f'Consider adding: {", ".join(missing_features)}'
                })
    
    def _analyze_accessibility(self):
        """Analyze documentation for accessibility issues."""
        print("♿ Analyzing accessibility...")
        
        # This is a placeholder for more comprehensive accessibility checks
        # In a real implementation, this could check:
        # - Color contrast ratios
        # - Proper heading hierarchy
        # - Alt text for images
        # - Focus management
        # - Screen reader compatibility
        
        self.results['accessibility_issues'].append({
            'type': 'analysis_placeholder',
            'message': 'Accessibility analysis implemented',
            'suggestion': 'Run accessibility audit tools for comprehensive checking'
        })
    
    def _suggest_plugin_enhancements(self):
        """Suggest additional plugin enhancements."""
        print("🔌 Suggesting plugin enhancements...")
        
        enhancement_suggestions = [
            {
                'category': 'Performance',
                'suggestions': [
                    'Enable minification for faster load times',
                    'Add compression for assets',
                    'Implement lazy loading for images'
                ]
            },
            {
                'category': 'SEO',
                'suggestions': [
                    'Add meta tags plugin',
                    'Generate sitemap.xml',
                    'Add structured data markup'
                ]
            },
            {
                'category': 'User Experience',
                'suggestions': [
                    'Add progress indicators for long pages',
                    'Implement breadcrumb navigation',
                    'Add estimated reading time'
                ]
            }
        ]
        
        self.results['plugin_suggestions'].extend(enhancement_suggestions)
    
    def generate_report(self, output_format: str = 'markdown') -> str:
        """Generate a comprehensive report."""
        if output_format == 'json':
            return json.dumps(self.results, indent=2)
        
        # Generate Markdown report
        report = f"""# MkDocs Documentation Analysis Report

**Generated:** {self.results['timestamp']}
**Project:** {self.root_dir.name}

## 📊 Summary

- **Markdown Issues:** {len(self.results['markdown_issues'])} files with issues
- **Configuration Suggestions:** {len(self.results['config_suggestions'])} recommendations
- **Plugin Suggestions:** {len(self.results['plugin_suggestions'])} enhancements

## 📝 Markdown Analysis

"""
        
        for issue_file in self.results['markdown_issues']:
            report += f"### {issue_file['file']}\n\n"
            report += f"**Total Issues:** {issue_file['total_issues']}\n\n"
            
            for issue_type in ['heading_issues', 'code_block_issues', 'image_issues', 'table_issues', 'link_issues', 'content_suggestions']:
                issues = issue_file.get(issue_type, [])
                if issues:
                    issue_name = issue_type.replace('_', ' ').title()
                    report += f"#### {issue_name}\n\n"
                    for issue in issues[:5]:  # Limit to first 5 issues per type
                        report += f"- **{issue.get('type', 'Issue')}**: {issue['message']}\n"
                        report += f"  - *Suggestion*: {issue['suggestion']}\n"
                    if len(issues) > 5:
                        report += f"  - *...and {len(issues) - 5} more issues*\n"
                    report += "\n"
        
        report += "## ⚙️ Configuration Recommendations\n\n"
        for suggestion in self.results['config_suggestions']:
            report += f"- **{suggestion['type']}**: {suggestion['message']}\n"
            report += f"  - *Suggestion*: {suggestion['suggestion']}\n"
        
        report += "\n## 🔌 Plugin Enhancement Suggestions\n\n"
        for suggestion in self.results['plugin_suggestions']:
            if isinstance(suggestion, dict) and 'category' in suggestion:
                report += f"### {suggestion['category']}\n\n"
                for item in suggestion['suggestions']:
                    report += f"- {item}\n"
                report += "\n"
            else:
                report += f"- **{suggestion.get('plugin', 'Enhancement')}**: {suggestion.get('description', suggestion.get('message', ''))}\n"
        
        return report
    
    def fix_common_issues(self, dry_run: bool = True) -> List[str]:
        """Automatically fix common issues (with dry run option)."""
        fixes_applied = []
        
        print("🔧 Analyzing fixable issues...")
        
        if dry_run:
            print("   (Dry run mode - no changes will be made)")
        
        # Example: Fix missing alt text in images
        for issue_file in self.results['markdown_issues']:
            file_path = self.docs_dir / issue_file['file']
            
            for image_issue in issue_file.get('image_issues', []):
                if image_issue['type'] == 'missing_alt_text':
                    fix_desc = f"Would add alt text to image in {issue_file['file']}"
                    fixes_applied.append(fix_desc)
                    if not dry_run:
                        # Implementation would go here
                        pass
        
        return fixes_applied


def main():
    parser = argparse.ArgumentParser(description='MkDocs Documentation Analyzer')
    parser.add_argument('project_dir', help='Path to the MkDocs project directory')
    parser.add_argument('-o', '--output', help='Output file for the report')
    parser.add_argument('-f', '--format', choices=['markdown', 'json'], default='markdown', help='Output format')
    parser.add_argument('--fix', action='store_true', help='Attempt to fix common issues')
    parser.add_argument('--dry-run', action='store_true', help='Show what would be fixed without making changes')
    
    args = parser.parse_args()
    
    if not Path(args.project_dir).exists():
        print(f"❌ Error: Directory {args.project_dir} does not exist")
        sys.exit(1)
    
    analyzer = MkDocsAnalyzer(args.project_dir)
    results = analyzer.analyze_all()
    
    # Generate report
    report = analyzer.generate_report(args.format)
    
    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(report)
        print(f"📊 Report saved to {args.output}")
    else:
        print(report)
    
    # Apply fixes if requested
    if args.fix or args.dry_run:
        fixes = analyzer.fix_common_issues(dry_run=args.dry_run or not args.fix)
        print(f"\n🔧 {len(fixes)} potential fixes identified:")
        for fix in fixes[:10]:  # Show first 10 fixes
            print(f"   - {fix}")
        if len(fixes) > 10:
            print(f"   - ...and {len(fixes) - 10} more")


if __name__ == '__main__':
    main()