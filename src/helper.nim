let last* = -1  # This is just an identifier to specify the last frame 


proc gen_clips*(clips:seq[ptr VSMap]):ptr VSMap =
  ## Puts the nodes from a sequence of VSMaps just into one (as needed by Splice)
  var nodes:seq[ptr VSNodeRef]
  result = createMap()
  for clip in clips:
    for item in clip.items:
      if item.`type` == ptNode:
        for i in 0..<clip.len(item):
          result.append( "clips", clip.propGetNode($item.key,i) )

proc `[]`*(vsmap:ptr VSMap;hs:HSlice):ptr VSMap =  #;clip:Natural=0
  ## vsmap[1..3] (returns a clip -vsmap- including only those frames)
  ## Only works on one clip
  let key = vsmap.key(0)
  assert key == "clip"
  let t   = vsmap.`type`(key)
  assert t == ptNode

  # How many nodes?
  let nNodes = vsmap.len(key)
  assert nNodes == 1

  # Make it work with `last` identifier
  var i = hs.a
  var j = hs.b
  # Get number of frames
  let node = vsmap.propGetNode("clip",0)
  let numFrames = node.getVideoInfo.numFrames
  if i < 0:
    i = numFrames + i
  if j < 0:
    j = numFrames + j

  var inverse = false
  if j < i: 
    (i,j) = (j,i)
    inverse = true

  result = vsmap.Trim(some(i),some(j))
  if inverse:
    result = result.Reverse

proc `[]`*(vsmap:ptr VSMap,hs:HSlice, n:int):ptr VSMap = 
  if n < 1:
    raise newException(ValueError, &"n={n} should be bigger than 1")

  vsmap[hs].SelectEvery(n, @[0])

proc `+`*(clip1:ptr VSMap, clip2:ptr VSMap):ptr VSMap =
  ## Adds two clips
  let clips = gen_clips(@[clip1, clip2])
  Splice(clips, mismatch=0.some)


proc `*`*(clip:ptr VSMap, n:int):ptr VSMap =
  ## Adds two clips
  var tmp = newSeq[ptr VSMap]()
  for i in 0..<n:
    tmp &= clip
  let clips = gen_clips(tmp)
  Splice(clips, mismatch=0.some)

proc `*`*(n:int, clip:ptr VSMap):ptr VSMap =
  clip * n

#SelectEvery
#Inverse