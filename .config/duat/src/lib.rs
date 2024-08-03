use duat::prelude::*;
use duat_core::ui::Constraint;
// Since duat_kak is a plugin, it must be used explicitely.
use duat_kak::{KeyMap, Mode, OnModeChange};
run! {
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
            selections_fmt " " main_byte
        );
        // As opposed to `builder.push`, this one
        // takes a user defined configuration.
        let (child, _) = builder.push_cfg(status_line);
        let cmd_line = CommandLine::cfg();
        // `push_cfg_to` pushes a widget to another.
        builder.push_cfg_to(cmd_line, child);
    });

    commands::add_for_widget::<CommandLine>(["collapse"], |_, area, _, _| {
        area.constrain_ver(Constraint::Length(10.0))?;

        Ok(None)
    }).unwrap();

    input::set(KeyMap::new());

    // This is a hook provided by duat-kak.
    hooks::add::<OnModeChange>(|(_, new)| match new {
        Mode::Insert => cursor::set_main(CursorShape::SteadyBar),
        _ => cursor::set_main(CursorShape::SteadyBlock),
    });

    // This is a form also provided by duat-kak.
    forms::set("Mode", Form::new().dark_magenta());
}
