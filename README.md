git clone https://github.com/111nat/ProPainter.git  

cd ProPainter  

Скачать веса https://github.com/sczhou/ProPainter/releases и положить в weights (только .pth)  

docker build -t propainter-gpu .  


`docker run --gpus all --rm -it -v ${PWD}\results:/app/results propainter-gpu (для PowerShell)`  

или  

`docker run --gpus all --rm -it -v $(pwd)/results:/app/results propainter-gpu`  
  
должна появиться папка results в папке ProPainter