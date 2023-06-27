classdef sequence
	properties (Access = public)
		data
		offset
	end
	
	methods
		function s = sequence(data, offset)
			% SEQUENCE   Sequence object
			%            S = SEQUENCE(DATA, OFFSET) creates sequence S
			%            using DATA and OFFSET
			%
			%            Your Name  1 Jan 20xx
			s.data = data;
			s.offset = offset;
        end
		
	
		function y = flip(x)
			% FLIP Flip a Matlab sequence structure x, so y = x[-n]
			% Create output sequence using new data and offset

            temp  = x.data(end:-1:1);
            ILx = length(x.data)+x.offset - 1;
			y = sequence(temp,-ILx);
		end
		
		function y = shift(x, n0)
			% SHIFT Shift a Matlab sequence structure x by integer amount n0
			%       so that y[n] = x[n - n0]
			
			% Create output sequence using new data and offset
			y = sequence(x.data,x.offset+n0);

            
		end
		
		function z = plus(x, y)
			% PLUS  Add x and y.
			% Either x and y or both will be sequence structures
			% Only one of them may be a number.

    if ~ isa(x,'sequence')
            z = sequence(x-y.data,y.offset);
            z = trim(z);
            return

  elseif ~ isa(y,'sequence')
        z = sequence(x.data -y,x.offset);
        z=trim(z);
        return
  end


			Lx = x.offset;length(x.data) - 1;
            Ly = y.offset;length(y.data) - 1;
            x_hat = [zeros(1,x.offset - y.offset), x.data zeros(1,Ly+Lx)];
            y_hat = [zeros(1,y.offset-x.offset), y.data zeros(1,Lx+Ly)];
            z_hat = x_hat + y_hat;
            z_offset = max(x.offset,y.offset);
            z = sequence(z_hat,z_offset);
            z = trim(z);
        end


        function x = trim(x)
            while x.data(1) == 0
                x.offset = x.offset + 1;
                x.data(1) = [];
            end
            while x.data(end) == 0
                x.data(end) = [];

            end
        end




		function z = minus(x, y)
           
			% MINUS Subtract x and y.
			% Either x and y or both will be sequence structures
			% Only one of them may be a number.
			
			% Create output sequence using new data and offset
          
  if ~ isa(x,'sequence')
            z = sequence(x-y.data,y.offset);
            z = trim(z);
            return

  elseif ~ isa(y,'sequence')
        z = sequence(x.data -y,x.offset);
        z=trim(z);
        return
  end


			Lx = x.offset;length(x.data) - 1;
            Ly = y.offset;length(y.data) - 1;
            x_hat = [zeros(1,x.offset - y.offset), x.data zeros(1,Ly-Lx)];
            y_hat = [zeros(1,y.offset-x.offset), y.data zeros(1,Lx-Ly)];
            z_hat = x_hat - y_hat;
            z_offset = min(x.offset,y.offset);
            z = sequence(z_hat,z_offset);
            z = trim(z);
        end


		
        function z = times(x, y)
			% TIMES Multiply x and y (i.e. .*)/
			% Either x and y or both will be sequence structures
			% Only one of them may be a number.
			
			% Create output sequence using new data and offset
			z = sequence(data, offset);
		end
		


		function stem(x)
			% STEM Display a Matlab sequence, x, using a stem plot.
		    Lix = x.offset + length(x.data)-1;
            stem(x.offset:Lix,x.data);
        end
	end
end

