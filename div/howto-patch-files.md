# How to Patch a File

First, create a patch file by comparing the original file to the modified file:

```bash
diff original-file modified-file > patch-file
```

Second, apply the patch file to the original file, thus recreating the modified file.

```bash
patch original-file patch-file
```
