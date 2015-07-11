#!/usr/local/bin/ruby
#
# XCode project management script for Zombie Hero : Revenge of Kiki (iOS game)
# It use xcodeproj to manage all around stuff
#
# author: @haxpor
# version: 0.1
#

require 'xcodeproj'
require 'colorize'

def printGroup(groups, level, isPrintChildren)

    # if the groups itself is nil so there's nothing, then return immediately
    if groups.nil?
        return nil
    end

    groups.each do |val|
        # if its children is empty, then print
        # if val.groups.empty?
            # indent for children
            for l in 1..level
                print "| ".red
            end

            # print group name
            print "#{val.display_name}"
            puts "/".yellow

            # print its children if needed
            if isPrintChildren
                unless val.children.objects.empty?
                    val.children.objects.each do |child|
                        # indent for child
                        for l in 1..level+1
                            print ". ".blue
                        end

                        # print child
                        puts "#{child.display_name}"
                    end
                end
            end

        # if it has children, then do it recursively
        #else
            printGroup(val.groups, level + 1, isPrintChildren)
        #end
    end
    
    return nil
end

# Check if parameters supplied correctly and enough
if ARGV.length != 1
    puts "Usage: zhmanage <command>"
    exit
end

# if all else is okay
# Get command from executing command line
command = ARGV[0];

xcode_project_path = '/Users/haxpor/Data/Projects/ZombieHero/zombie-hero/'
xcode_project_name = 'ZombieHero.xcodeproj'

project_file = "#{xcode_project_path}#{xcode_project_name}"

puts "Processing #{project_file} ..."

project = Xcodeproj::Project.open(project_file)

if command == "listgroup"
    printGroup(project.groups, 0, false)
else
    puts "#{command} command not recognized."
end
