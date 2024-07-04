function js
  set -l id $fish_pid
  command mkdir -p /tmp/$USER
  set output_file "/tmp/$USER/joshuto-cwd-$id"
  command env joshuto --output-file "$output_file" $argv
  switch $status
    case 0
    # output contains current directory
    case 101
      cd (cat "$output_file")
    # output selected files
    case 102
    case *
      echo "Exit code: $status"
  end
end
