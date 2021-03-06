return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.16.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 25,
  height = 10,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "Desert",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 1,
      margin = 1,
      image = "../../../Program Files/Tiled/examples/tmw_desert_spacing.png",
      imagewidth = 265,
      imageheight = 199,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {
        {
          name = "Desert",
          tile = 29,
          properties = {}
        },
        {
          name = "Brick",
          tile = 9,
          properties = {}
        },
        {
          name = "Cobblestone",
          tile = 33,
          properties = {}
        },
        {
          name = "Dirt",
          tile = 14,
          properties = {}
        }
      },
      tilecount = 48,
      tiles = {
        {
          id = 0,
          terrain = { 0, 0, 0, 1 }
        },
        {
          id = 1,
          terrain = { 0, 0, 1, 1 }
        },
        {
          id = 2,
          terrain = { 0, 0, 1, 0 }
        },
        {
          id = 3,
          terrain = { 3, 3, 3, 0 }
        },
        {
          id = 4,
          terrain = { 3, 3, 0, 3 }
        },
        {
          id = 5,
          terrain = { 0, 0, 0, 3 }
        },
        {
          id = 6,
          terrain = { 0, 0, 3, 3 }
        },
        {
          id = 7,
          terrain = { 0, 0, 3, 0 }
        },
        {
          id = 8,
          terrain = { 0, 1, 0, 1 }
        },
        {
          id = 9,
          terrain = { 1, 1, 1, 1 }
        },
        {
          id = 10,
          terrain = { 1, 0, 1, 0 }
        },
        {
          id = 11,
          terrain = { 3, 0, 3, 3 }
        },
        {
          id = 12,
          terrain = { 0, 3, 3, 3 }
        },
        {
          id = 13,
          terrain = { 0, 3, 0, 3 }
        },
        {
          id = 14,
          terrain = { 3, 3, 3, 3 }
        },
        {
          id = 15,
          terrain = { 3, 0, 3, 0 }
        },
        {
          id = 16,
          terrain = { 0, 1, 0, 0 }
        },
        {
          id = 17,
          terrain = { 1, 1, 0, 0 }
        },
        {
          id = 18,
          terrain = { 1, 0, 0, 0 }
        },
        {
          id = 19,
          terrain = { 1, 1, 1, 0 }
        },
        {
          id = 20,
          terrain = { 1, 1, 0, 1 }
        },
        {
          id = 21,
          terrain = { 0, 3, 0, 0 }
        },
        {
          id = 22,
          terrain = { 3, 3, 0, 0 }
        },
        {
          id = 23,
          terrain = { 3, 0, 0, 0 }
        },
        {
          id = 24,
          terrain = { 0, 0, 0, 2 }
        },
        {
          id = 25,
          terrain = { 0, 0, 2, 2 }
        },
        {
          id = 26,
          terrain = { 0, 0, 2, 0 }
        },
        {
          id = 27,
          terrain = { 1, 0, 1, 1 }
        },
        {
          id = 28,
          terrain = { 0, 1, 1, 1 }
        },
        {
          id = 29,
          terrain = { 0, 0, 0, 0 }
        },
        {
          id = 30,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        },
        {
          id = 31,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        },
        {
          id = 32,
          terrain = { 0, 2, 0, 2 }
        },
        {
          id = 33,
          terrain = { 2, 2, 2, 2 }
        },
        {
          id = 34,
          terrain = { 2, 0, 2, 0 }
        },
        {
          id = 35,
          terrain = { 2, 2, 2, 0 }
        },
        {
          id = 36,
          terrain = { 2, 2, 0, 2 }
        },
        {
          id = 37,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        },
        {
          id = 38,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        },
        {
          id = 39,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        },
        {
          id = 40,
          terrain = { 0, 2, 0, 0 }
        },
        {
          id = 41,
          terrain = { 2, 2, 0, 0 }
        },
        {
          id = 42,
          terrain = { 2, 0, 0, 0 }
        },
        {
          id = 43,
          terrain = { 2, 0, 2, 2 }
        },
        {
          id = 44,
          terrain = { 0, 2, 2, 2 }
        },
        {
          id = 45,
          terrain = { 0, 0, 0, 0 },
          probability = 0
        },
        {
          id = 46,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        },
        {
          id = 47,
          terrain = { 0, 0, 0, 0 },
          probability = 0.01
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Слой тайлов 1",
      x = 0,
      y = 0,
      width = 25,
      height = 10,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 34, 30, 30, 30, 30,
        30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 34, 34, 30, 30, 30, 30,
        30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30, 34, 30, 30, 30, 30, 30,
        30, 30, 30, 30, 34, 34, 34, 30, 30, 30, 30, 30, 30, 30, 34, 30, 30, 30, 30, 34, 30, 30, 30, 30, 30,
        30, 30, 30, 34, 34, 30, 34, 34, 30, 30, 30, 30, 30, 34, 34, 30, 30, 30, 34, 30, 34, 34, 34, 34, 30,
        30, 30, 34, 34, 30, 30, 30, 34, 34, 30, 30, 30, 34, 34, 34, 30, 30, 30, 34, 30, 30, 30, 30, 30, 30,
        30, 34, 34, 30, 30, 30, 30, 30, 34, 34, 30, 30, 34, 30, 30, 34, 30, 30, 34, 30, 30, 30, 30, 30, 30,
        30, 34, 30, 30, 30, 30, 34, 34, 30, 30, 30, 34, 34, 34, 34, 34, 30, 34, 34, 34, 34, 30, 30, 30, 30,
        34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34,
        34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34
      }
    }
  }
}
