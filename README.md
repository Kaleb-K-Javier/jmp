# Job market paper: Kaleb K. Javier

**Cheap to Keep: Insurance Pricing and the Retirement of Hazardous Capital**

Latest draft (permanent link):
https://kaleb-k-javier.github.io/jmp/Javier_JMP.pdf

Website: https://www.kalebkjavier.com

## Updating the draft

Render the paper in the UST repo, then run:

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\kaleb\Documents\jmp\update_jmp.ps1
```

The script copies `Reports/Paper/04_JMP_Paper.pdf` over `Javier_JMP.pdf`, commits it, and
pushes. The link above stays the same. GitHub Pages serves the new file within a few
minutes. To post a different file, pass `-Source "path\to\file.pdf"`.
