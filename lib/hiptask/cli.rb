require 'thor'
require 'hiptask/list'

module Hiptask

    class CLI < Thor

        @@filename = './tasks.txt'

        def self.start(argv)
            @@list = List.new(@@filename)
            super argv
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


        desc "undo ID", "Complete a task"
        def undo(id)
            @@list.undo(id)
            list
        end


        desc "delete ID", "Delete a task"
        def delete(id)
            @@list.delete(id)
            list
        end

    end

end
