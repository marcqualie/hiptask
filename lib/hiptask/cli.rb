require 'thor'
require 'hiptask/list'
require 'hiptask/version'
require 'yaml'

module Hiptask

    class CLI < Thor

        include Thor::Shell

        default_task :list


        @@config = {}
        @@config_file = ENV['HOME'] + '/.hiptask/config.yml'
        @@tasks_file = ENV['HOME'] + '/.hiptask/tasks.txt'
        @@message = nil


        def self.start(argv)

            # Config
            config_dir = File.dirname(@@config_file)
            Dir.mkdir(config_dir) unless Dir.exists? config_dir
            unless File.exists? @@config_file
                file = File.open(@@config_file, "w+") { |file |
                    file.puts "tasks_file: " + @@tasks_file
                }
            end
            @@config = YAML::load_file(@@config_file)
            @@tasks_file = @@config['tasks_file'] if @@config['tasks_file']

            # Environment
            @@list = List.new(@@tasks_file)

            super argv

        end


        desc "config [ACTION] [KEY] [VAL]", "Get a config variable"
        def config(action=nil, key=nil, value=nil)
            case action
                when 'get'
                    puts @@config[key]
                when 'set'
                    if value
                        @@config[key] = value
                        puts key + ' = ' + value.to_s
                    else
                        @@config.delete(key) unless value
                        puts "deleted " + key
                    end
                    File.open(@@config_file, "w") { |file|
                        YAML.dump(@@config, file)
                    }
                when 'delete'
                    puts "deleted " + key
                    @@config.delete(key)
                    File.open(@@config_file, "w") { |file|
                        YAML.dump(@@config, file)
                    }
                else
                    puts @@config
                end
        end


        desc "list", "Display your task list"
        def list()

            say "\n"
            if @@message
                say "  [ #{@@message} ]\n", Color::GREEN
                return
            end

            say "  #{@@list.items.length} Items", Color::GREEN
            say "\n"
            if @@list.items.length > 0
                @@list.items.each_with_index { |item, index|
                    index = index + 1
                    say "  #{index.to_s.ljust(2)}", Color::YELLOW
                    if item.start_with? ">"
                        say " [x] "
                        say "#{item[1, item.length - 1]}"
                    else
                        say " [ ] "
                        say "#{item}"
                    end
                }
            else
                say "  Add a new task with: hiptask add \"Get milk\"", Color::YELLOW
            end
            puts " "

        end


        desc "add CONTENT", "Add a new task"
        def add(content)
            @@list.add(content)
            @@message = "Task #{@@list.items.length - 1} was created"
            list
        end


        desc "do ID", "Complete a task"
        def do(id)
            @@list.do(id)
            @@message = "Task #{id} is now marked as complete"
            list
        end


        desc "undo ID", "Un-complete a task"
        def undo(id)
            @@list.undo(id)
            @@message = "Task #{id} is now marked as incomplete"
            list
        end


        desc "update ID CONTENT", "Update a task"
        def update(id, content)
            @@list.update(id, content)
            @@message = "Task #{id} updated"
            list
        end


        desc "delete ID", "Delete a task"
        def delete(id)
            @@list.delete(id)
            @@message = "Task #{id} deleted"
            list
        end


        desc "version", "Displays current version"
        def version
            puts "hiptask-#{Hiptask::VERSION}"
        end


    end

end
