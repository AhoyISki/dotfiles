setup_duat!(setup);
use duat::prelude::*;
// Since duat_kak is a plugin, it must be used explicitely.
use duat_kak::{KeyMap, Mode, OnModeChange};

fn setup() {
    // The print module manages the printing of files.
    print::wrap_on_width();

    hooks::remove_group("FileWidgets");
    // This hook lets you push widgets to the files.
    hooks::add::<OnFileOpen>(|builder| {
        // By default, these go on the left.
        builder.push::<VertRule>();
        builder.push::<LineNumbers>();
    });
    hooks::remove_group("WindowWidgets");
    // Same, but on the edges of the window.
    hooks::add::<OnWindowOpen>(|builder| {
        // "[" "]" pairs change the style of text.
        let status_line = status!(
             [File] { File::name } " "
             { KeyMap::mode_fmt } " "
             selections_fmt " " main_fmt
        );
        // As opposed to `builder.push`, this one
        // takes a user defined configuration.
        let (child, _) = builder.push_cfg(status_line);
        let cmd_line = CommandLine::cfg().left_ratioed(4, 10);
        // `push_cfg_to` pushes a widget to another.
        builder.push_cfg_to(cmd_line, child);
    });

    commands::add_for_widget::<File>(["collapse"], |_, area, _, _| {
        area.constrain_ver(Constraint::Length(0.0))?;

        Ok(None)
    })
    .unwrap();

    input::set(KeyMap::new());

    cursor::unset_main();
    forms::set("MainCursor", Form::new().reverse());
    forms::set("ExtraCursor", Form::new().on_yellow());
    // This is a hook provided by duat-kak.
    hooks::add::<OnModeChange>(|(_, new)| {
        forms::set(
            "MainCursor",
            match new {
                Mode::Insert => Form::black().on_magenta(),
                _ => Form::new().reverse(),
            },
        );
        forms::set(
            "ExtraCursor",
            match new {
                Mode::Insert => Form::black().on_blue(),
                _ => Form::new().on_yellow(),
            },
        );
    });

    // This is a form also provided by duat-kak.
    forms::set("Mode", Form::dark_magenta());
}
