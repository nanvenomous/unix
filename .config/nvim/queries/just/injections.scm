; Inject bash for #!/usr/bin/env bash shebangs
((recipe_body
  (shebang) @_shebang
  (#match? @_shebang "bash"))
 @injection.content
 (#set! injection.language "bash")
 (#set! injection.include-children true))

; Inject sh
((recipe_body
  (shebang) @_shebang
  (#match? @_shebang "/sh$"))
 @injection.content
 (#set! injection.language "bash")
 (#set! injection.include-children true))

; Inject nushell
((recipe_body
  (shebang) @_shebang
  (#match? @_shebang "nu"))
 @injection.content
 (#set! injection.language "nu")
 (#set! injection.include-children true))

; Inject python
((recipe_body
  (shebang) @_shebang
  (#match? @_shebang "python"))
 @injection.content
 (#set! injection.language "python")
 (#set! injection.include-children true))
