require 'thor'
require 'hiptask/list'
require 'hiptask/version'
require 'yaml'

module Hiptask

    class CLI < Thor


        @@config = {}
        @@config_file = ENV['HOME'] + '/.hiptask/config.yml'
        @@tasks_file = ENV['HOME'] + '/.hiptask/tasks.txt'


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

            puts " "
            puts "  \033[32;1m#{@@list.items.length} Items\033[0m"
            puts " "
            @@list.items.each_with_index do |item, index|
                index = index + 1
                print "  \033[33m#{index.to_s.ljust(2)}\033[0m"
                if item.start_with? ">"
                    print " [x] "
                    puts "#{item[1, item.length - 1]}"
                else
                    print " [ ] "
                    puts "#{item}"
                end
            end
            puts " "

        end


        desc "add CONTENT", "Add a new task"
        def add(content)
            @@list.add(content)
            list
        end


        desc "do ID", "Complete a task"
        def do(id)
            @@list.do(id)
            list
        end


        desc "undo ID", "Un-complete a task"
        def undo(id)
            @@list.undo(id)
            list
        end


        desc "update ID CONTENT", "Update a task"
        def update(id, content)
            @@list.update(id, content)
            list
        end


        desc "delete ID", "Delete a task"
        def delete(id)
            @@list.delete(id)
            list
        end


        desc "version", "Displays current version"
        def version
            puts "Hiptask #{Hiptask::VERSION}"
        end


    end

end
