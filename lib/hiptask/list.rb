module Hiptask

    class List

        attr_reader :items

        def initialize(filename)

            @filename = filename

            # Create file if it doesn't exist
            File.open(filename, "w+") unless File.exists?(filename)

            # Load Content from File
            @items = []
            @file = File.open(filename, "r")
            @file.each do |line|
                @items.push line.strip
            end
            @file.close

        end


        def find_by_id(id)
            id = id.to_i - 1
            raise "ID must be greater than 0" if id < 0
            task = nil
            @items.each_with_index { |line, index|
                if index == id
                    task = line
                    break
                end
            }
            return task
        end


        def add(content)
            File.open(@filename, "a") { |file|
                file.puts content
            }
            @items.push content
        end


        def do(id)
            id = id.to_i - 1
            raise "ID must be greater than 0" if id < 0
            raise "Task not found" unless @items[id]
            @items[id] = ">" + @items[id] unless @items[id].start_with? ">"
            save
        end


        def undo(id)
            id = id.to_i - 1
            raise "ID must be greater than 0" if id < 0
            raise "Task not found" unless @items[id]
            @items[id] = @items[id][1, @items[id].length - 1] if @items[id].start_with? ">"
            save
        end


        def update(id, content)
            id = id.to_i - 1
            raise "ID must be greater than 0" if id < 0
            raise "Task not found" unless @items[id]
            done = @items[id].start_with? ">"
            @items[id] = (done ? ">" : "") + content
            save
        end


        def delete(id)
            id = id.to_i - 1
            raise "ID must be greater than 0" if id < 0
            raise "Task not found" unless @items[id]
            @items.delete_at id
            save
        end


        private
        def save
            File.open(@filename, "w+") { |file|
                file.puts @items
            }
        end

    end

end
