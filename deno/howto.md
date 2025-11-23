# Deno

Initialize a new project (creates according folder) and install the default dependencies:

    $ deno init foo
    $ cd foo
    $ deno install

Run the tests (`main_test.ts`):

    $ deno test

Run the program (`main.ts`):

    $ deno run main.ts

Run the program (`main.ts`), and re-run it automatically after file changes:

    $ deno run --watch main.ts

List all tasks defined in `deno.json`:

    $ deno task

Run the `dev` task, which re-runs `main.ts` after file changes:

    $ deno task dev

