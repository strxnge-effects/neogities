require "neocities"
require "pastel"
require "tty-prompt"

puts "updating files on neocities..."

class Neogities
  @pastel = Pastel.new eachline: "\n"
  status = File.read("status.txt")

  # > neocities gem setup
  configpath = File.join(Neocities::CLI.app_config_path("neocities"), "config.json")

  begin # fetch api key
    file = File.read configpath
    data = JSON.load file

    if data
      yourkey = data["API_KEY"].strip
    end

  rescue Errno::ENOENT
    yourkey = nil
    print "API key not found, please login with the neocities module :("
  end

  @neogities = Neocities::Client.new(api_key: yourkey) # create new instance


  # > uploading n things
  def self.upload_file(path)
    print "UPLOAD: #{path}..."

    resp = @neogities.upload(path, path)
    self.display_response(resp)
  end

  def self.delete_file(path)
    print "DELETE: #{path}..."

    resp = @neogities.delete(path)
    self.display_response(resp)
  end

  def self.rename_file(line)
    split2 = line[1].split
    print "RENAME: #{split2[0]} to #{split2[2]}..."

    resp = @neogities.upload(split2[2], split2[2])
    @neogities.delete(split2[0])
    self.display_response(resp)
  end

  def self.display_response(resp) # copied this from the gem lol
    if resp[:result] == 'success'
      puts "#{@pastel.green.bold 'SUCCESS'}"

    elsif resp[:result] == 'error' && resp[:error_type] == 'file_exists'
      out = "#{@pastel.yellow.bold 'EXISTS: '} #{resp[:message]}"
      out += " (#{resp[:error_type]})" if resp[:error_type]
      puts out

    else
      out = "#{@pastel.red.bold 'ERROR:'} #{resp[:message]}"
      out += " (#{resp[:error_type]})" if resp[:error_type]
      puts out
    end
  end


  begin
    for line in status.split("\n")
      unless line.include?(".gitignore")
        splitted = Array(splitted) << [line[0..1], line[3..-1]]
      end
    end

    # > update website on neocities
    for line in splitted
      if (line[0] == "M " || line[0] == "A ") # modified / added
        self.upload_file(line[1])

      elsif line[0] == "D " # deleted
        self.delete_file(line[1])

      elsif line[0] == "R " # renamed
        self.rename_file(line)
      end
    end

  rescue NoMethodError # returned if status.txt is blank
    puts "INFO: status.txt is blank. your changes will not be pushed to neocities."
  end

  print "\n"
end
