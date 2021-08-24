module Rcon
  class Query
    #
    # Convenience method to scrape input from cvar output and return that data.
    # Returns integers as a numeric type if possible.
    #
    # ex: rcon.cvar("mp_friendlyfire") => 1
    #
    # NOTE: This file has not been updated since previous version. Please be aware there may be outstanding Ruby2 bugs

    def cvar(cvar_name)
      response = command(cvar_name)
      match = /^.+?\s(?:is|=)\s"([^"]+)".*$/.match response
      match = match[1]
      if /\D/.match? match
        match
      else
        match.to_i
      end
    end
  end
end
