# Emacs

- `M` stands for the `alt` key
- `C` stands for the `control` key
    - `C-x` means: press the `control` and the `x` key simultaneously
    - `C-x C-c` means: press the `control` and the `x` key simultaneously, then
      press the `control` and the `c` key simultaneously (or hold the `control`
      key down, press the `x` key and then press the `c` key)

## Basic interaction

- Exit Emacs: `C-x C-c`
- Suspend Emacs: `C-z`
    - Bring it back using the `fg` shell command
- Stop current command: `C-g`
- Undo last command: `C-x u`
- Help
    - Getting help: `C-h ?`
    - Get help on a specific command: `C-h c [command]`
    - Get more help on a specific command: `C-h k [command]`

## Movement

- Buffer
    - Move to the beginning of the current buffer: `M-<`
    - Move to the end of the current buffer: `M->`
- Screen
    - Move one screen down: `C-v`
    - Move one screen up: `M-v`
    - Center screen at cursor position: `C-l`
- Line
    - Move to the next line: `C-n`
    - Move to the previous line: `C-p`
    - Move to the beginning of the current line: `C-a`
    - Move to the end of the current line: `C-e`
- Sentence
    - Move to the beginning of the current sentence: `M-a`
    - Move to the end of the current sentence: `M-e`
- Word
    - Move to the next word: `M-f`
    - Move to the previous word: `M-b`
- Character
    - Move to the next character: `C-f`
    - Move to the previous character: `C-b`
- Multiple Units
    - Move by `n` units: `C-u n [unit]`
    - Move up eight lines: `C-u 8 C-p`:w
    - Move three words forward: `C-u 3 M-f`
    - Move twenty charachters forward: `C-u 20 C-f`

## Deleting, Killing and Yanking

Deleting just removes text, while killing removes text and stores it for later
yanking (re-insertion).

- Delete the character under the cursor: `C-d`
- Kill to the end of the word under the cursor: `M-d`
- Kill from the cursor position to the end of the line: `C-k`
    - Press `C-k` again to kill the Newline character
- Kill from the cursor position to the end of the sentence: `M-k`
- Kill multiple units
    - Kill five lines: `C-u 5 C-k`
- Kill an entire selection
    1. Start selecting text: `C-[Space]`
    2. Move to set selection
    3. Kill selection: `C-w`
- Yank (i.e. insert) killed text at cursor position: `C-y`
    - Replace yanked text with earlier killing: `M-y` (cycle through killings)

## Files and Buffers

- Open a file: `C-x C-f`
- Save a file: `C-x C-s`
- Save some buffers: `C-x s`
- Show buffers: `C-x C-b`
- Switch to a buffer: `C-x b`

## Searching

- Searching text
    - Start searching: `C-s`
    - Enter search term
    - Cycle through results (forward): `C-s`
    - Cycle through results (backward): `C-r`
    - End search: `C-g`

## Windows

- Split current buffer into two windows: `C-x 2`
- Maximize current window: `C-x 1`
- Move to other window: `C-x o`
- Scroll text in the other window: `C-M-v`
