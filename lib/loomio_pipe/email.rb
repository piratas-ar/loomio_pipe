#
# © 2015-2016 Nicolás Reynolds <fauno@partidopirata.com.ar>
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
module LoomioPipe
  class Email
    attr_reader :email, :body, :to, :from

    def initialize(email)
      @email = email

      find_comment_in_email_body!
      process_email_params!
    end

    private
      # Returns a clean comment from the email body
      def find_comment_in_email_body!
        if @email.multipart?
          if @email.text_part.decoded.empty?
            body = @email.html_part
          else
            body = @email.text_part
          end
        else
          body = @email.body
        end

        @body = cleanup(body)
      end

      # Cleans the email body from extra formatting.  By removing the
      # signature we avoid posting the user links loomio puts at the
      # end.
      #
      # It leaves quoting in case people follows netiquette :)
      #
      # TODO use html2markdown or reverse_markdown to convert from html
      # email
      def cleanup(body)
        # Get the charset
        charset = @email.charset || body.charset
        # Decode
        body = body.decoded.force_encoding(charset).encode('UTF-8')
        # Remove html tags if the body is in html
        body.gsub!(/<[^>]*>/m, '')
        # Remove extra new lines from the top
        body.gsub!(/\A\n*/m,'')
        # Remove signatures
        body.gsub!(/\n*^(--|—) ?\n.*/m,'')

        body
      end

      # Retrieves key-values from the recipient address
      def process_email_params!
        # Get our address
        address = @email.to.select { |e| e.start_with?('loomio+') }.first
        @to     = address.split('+', 2).last
        @from   = @email.from.first
      end
  end
end
