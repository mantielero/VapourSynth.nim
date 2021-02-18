import ../src/vapoursynth
import strformat

# Create a map
let vsmap = createMap()

# Append 
vsmap.append( "This", 1)
vsmap.append( "is", 22)
vsmap.append( "a", 52.2)
vsmap.append( "hello", "world")
vsmap.append( "This", 4)  # This append an integer within the existing key "This"

# Pretty print the vsmap.
echo $vsmap

# Show some data
echo "Number of items in vsmap: ", vsmap.len

echo "=================================="
for item in vsmap:
  echo fmt"Item  key: {item.key}"
  echo fmt"     type: {item.`type`}"
  echo fmt"   length: {vsmap.len(item)}"
echo "=================================="


# Show one of the items within the map
echo "Second integer within key \"This\": ", vsmap.propGetInt("This", 1)

# Show some keys (the order is not maintained)
echo vsmap.key(0)  # Shows "This"
echo vsmap.key(1)

# 

#echo vsmap.propGetData("hola", -1)
#echo vsmap["hola"]

# Managing memory
API.freeMap(vsmap)
API.freeCore(CORE)