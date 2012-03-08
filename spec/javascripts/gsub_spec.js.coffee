describe "gsub", ->
  it "replaces hash key with hash value", ->
    expect("%{x1} %{x2}".gsub { x1: "abc", x2: "def" }).toEqual("abc def")

  describe "a key was used multiple times", ->
    it "replaces the key with value multiple times", ->
      expect("%{x1} %{x1}".gsub { x1: "abc", x2: "def" }).toEqual("abc abc")

  describe "a place holder is url encoded", ->
    it "replaces the place holder with value also", ->
      expect("%%7Bx1%7D".gsub { x1: "abc" }).toEqual("abc")
