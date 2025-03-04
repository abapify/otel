## General ABAP requirements

### Naming conventions

- do not use any suffixes or prefixes in the type names unless it is required
- do not use any suffixes (like ty\_) or prefixes in the interface types

### ABAP types references

- please remember that in ABAP you can't reference a local type unless you declared it in the same file prior to the reference
- this means you need to apply the right order of types, not same as in source file

### Abapgit

- every generated .abap file should come with a separate abapgit descriptor file
- do not skip any single descriptor file. Since your output will be used in CI/CD - every file matters even if they are similar
