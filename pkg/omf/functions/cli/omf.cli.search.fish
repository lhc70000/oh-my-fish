function omf.cli.search -d 'Searches all available packages'
  switch (count $argv);
    case 1;
      echo (omf::under)"Packages"(omf::off)
      __omf.cli.search.output type:package name:$argv[1]
      echo
      echo (omf::under)"Themes"(omf::off)
      __omf.cli.search.output type:theme name:$argv[1]

    case 2;
      switch "$argv[1]"
        case "-pkg" "--package";
          __omf.cli.search.output type:package name:$argv[2]
        case "-t" "--theme";
          __omf.cli.search.output type:theme name:$argv[2]
        case '*';
          omf.cli.help search
          return 1
      end

    case '*';
      omf.cli.help search
      return 1
  end
end

function __omf.cli.search.output
  for package in (omf.db.query $argv)
    set -l desc (omf.db.info $package description)
    echo "$package - $desc"
  end
end
