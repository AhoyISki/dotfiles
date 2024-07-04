// The prelude contains all of the commonly used commands.
use duat::prelude::{ui::VertRule, *};
// An `InputMethod` for `File`s.
use duat_kak::{KeyMap, Mode, OnModeChange};

// This macro expands to the function that Duat understands.
// Will be replaced by a proc-macro at some point.
run! {
    print::wrap_on_width();
    // Resets all existant hooks related to the opening of
    // `File`s.
    hooks::remove_group("FileWidgets");
    // Sets new hooks for that.
    // hooks::add::<OnFileOpen>(|builder| {
    //     // Push some widgets to the edge of the file, in order,
    //     // from inner to outer.
    //     //
    //     // By default, these two widgets go on the left, but
    //     // you can override that:
    //     // // *Uncomment me* //
    //     // let cfg = VertRule::cfg().on_the_right();
    //     // builder.push_cfg(cfg);
    //     // let cfg = LineNumbers::cfg()
    //     //     .on_the_right()
    //     //     .align_right()
    //     //     .align_main_left();
    //     // builder.push_cfg(cfg);
    //     // //
    //     builder.push::<VertRule>();
    //     builder.push::<LineNumbers>();
    // });

    // Resets all existant hooks related to the opening of
    // windows.
    hooks::remove_group("WindowWidgets");
    // Sets new hooks for that.
    hooks::add::<OnWindowOpen>(|builder| {
        // A macro to format a StatusLine.
        let status = status!(
            // A `Form` is enclosed in `[` `]` pairs, and sets
            // the text formatting.
            // The "Default" form is abbreviated as `[]`.
            [File]
            // A function that reads from a `File`. Anything
            // that isn't a `Form` is treated as an expression.
            // Note: Functions in paths need to be bracketed.
            { File::name }
            // Any type that implements `Into<Text>` works.
            " "
            // You can also use closures. This one reads from a
            // `duat_kak::KeyMap`.
            // Since this function returns a `Text`, it can add
            // `Tag`s alongside the string, including forms.
            // In this case, the form "Mode" is being added.
            { |map: &KeyMap| KeyMap::mode_fmt(map) } " "
            // Finally, these two functions return `Text`s.
            // Any function that returns `Text` should be have
            // the `_fmt` suffix, for consistency.
            // selections_fmt " " main_fmt
        );

        // Push a widget to a specific are, in this case, the
        // new area housing the `StatusLine`.
        let (child, _) = builder.push_cfg(status);
        builder.push_cfg_to(CommandLine::cfg().left_with_percent(30), child);
    });

    // Sets a new `InputMethod for `File`s.
    set_input(KeyMap::new());

    hooks::add::<OnModeChange>(|(_, new)| match new {
        Mode::Insert => print::main_cursor(Form::new().reverse(), Some(CursorShape::BlinkingBar)),
        Mode::Normal | Mode::GoTo | Mode::View | Mode::Command => {
            print::main_cursor(Form::new().reverse(), Some(CursorShape::SteadyBlock))
        }
    });

    // Modifies the "Mode" `Form`, created by `KeyMap::new`
    // method.
    print::forms::set("Mode", Form::new().dark_magenta());
}
