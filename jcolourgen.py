import sys
import PIL
from PIL import Image

im = Image.open(str(sys.argv[1]))
w, h = im.size
quantized = im.quantize(colors=5, kmeans=3)
convert_rgb = quantized.convert('RGB')
colors = convert_rgb.getcolors(w*h)
main_color = sorted(colors)[-1]
print str('#%02x%02x%02x' %  main_color[1])
