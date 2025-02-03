require "neocities"
require "tty-prompt"

class Neogities
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
    print "API key not found, please login usig the neocities module :("
  end

  @neogities = Neocities::Client.new(api_key: yourkey) # create new instance


  # > uploading n things
  def self.upload_file(path)
    print "upload: " + path + "..."
    resp = @neogities.upload(path, path)
    self.display_response(resp)
  end

  def self.delete_file(path)
    print "delete: " + path + "..."
    resp = @neogities.delete(path)
    self.display_response(resp)
  end

  def self.rename_file(line)
    split2 = line[1].split
    print "rename: " + split2[0] + " to " + split2[2] + "\n" + "..."
    resp = @neogities.upload(split2[2], split2[2])
    self.delete_file(split2[0])
    self.display_response(resp)
  end

  def self.display_response(resp) # copied this from the gem lol
    if resp[:result] == 'success'
      puts "SUCCESS"
    elsif resp[:result] == 'error' && resp[:error_type] == 'file_exists'
      out = "EXISTS: " + resp[:message]
      out += " (#{resp[:error_type]})" if resp[:error_type]
      puts out
    else
      out = "ERROR: " + resp[:message]
      out += " (#{resp[:error_type]})" if resp[:error_type]
      puts out
    end
  end


  for line in status.split("\n")
    splitted = Array(splitted) << line.split(" ", 2)
    # nvm spaces will NOT work.. idk why. get em outta your file names!!!
  end


  # > do the thing
  for line in splitted
    if (line[0] == "M" || line[0] == "A") # modified / added
      self.upload_file(line[1])
    elsif line[0] == "D" # deleted
      self.delete_file(line[1])
    elsif line[0] == "R" # renamed
      self.rename_file(line)
    else # anything else idc
      puts "ignore: #{line[1]}"
    end
  end
end
