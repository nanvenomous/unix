
local llamacpp = require("llm.providers.llamacpp")
local llmutil = require('llm.util')

local function create_llm_opts(model)
  return {
    server_start = {
      command = "/home/gin/projects/3p/llama.cpp/build/bin/server",
      args = {
        "-m", model,
        "-c", 2048,
        "-ngl", 70,
      }
    },
  }
end
local llm_builder = function(input, context)
  return {
    prompt = llamacpp.llama_2_user_prompt({
      user = context.args or "",
      message = input
    })
  }
end

require("llm").setup({
  prompts = {
    llamacpp = {
      provider = llamacpp,
      options = create_llm_opts("/home/gin/.local/share/nvim/llama.cpp/models/codellama-13b.Q4_K_M.gguf"),
      builder = function(input, context)
        return {
          prompt = llamacpp.llama_2_user_prompt({
            user = context.args or "",
            message = input
          })
        }
      end,
    },
    ask = {
      provider = llamacpp,
      options = create_llm_opts("/home/gin/projects/3p/llama.cpp/models/llama-2-13b-chat.ggmlv3.q4_1.bin"),
      builder = llm_builder,
    }
  },
})


