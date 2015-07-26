#
# © 2015 Nicolás Reynolds <fauno@partidopirata.com.ar
#
# This file is part of loomio_pipe
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
require 'httparty'
require 'mail'
require 'cgi'
require 'loomio_pipe/version'
require 'loomio_pipe/email'

module LoomioPipe
  class Post
    include HTTParty
    base_uri ENV['LOOMIO_API_URL']

    def initialize(email)
      @email = email
    end

    def process!
      self.class.post('/v1/comments/',
        body: {
          comment: {
            discussion_id: @email.discussion,
            body: @email.body,
            uses_markdown: true
          }
        },
        headers: { 'Loomio-User-Id'       => @email.user,
                   'Loomio-Email-API-Key' => @email.api_key })
    end
  end
end
