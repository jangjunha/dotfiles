```bash
mkdir -p in/ out/
cp /System/Library/Fonts/Monaco.ttf in/
container run --rm -v ./in:/in -v ./out:/out nerdfonts/patcher -c
```
