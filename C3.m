%specify the number of input values
total = 1001;   % total number of inputs
number = (total-1)/2;

%Learned weights
w_input = [1.029141 ];
w_hidden = [2.374782 2.824092 2.174076 ];
w_output = [1.946559 0.506498 1.792632 ];
%Learned Bias
b_input = [-0.958094 ];
b_hidden = [0.750705 0.852179 0.300535 ];
b_output = [0.625551 ];

%initialising the limit and pi
limit = 0.25;
pi=3.1;

%calculate the input values
x_input = -pi*limit:pi*limit/number:pi*limit;




%Sigmoid function G(s)
function [ out ] = sigmoidd( s )
	out = (1 - exp(-2*s)) ./ (1 + exp(-2*s));
end

%Sigmoid derivative function G'(s)
function [ out ] = sigmoidd_derivative( s )
	out = (4 * exp(-2*s)) ./ ((1 + exp(-2*s)) .* (1 + exp(-2*s))) ;
end


function [ out ] = forward_hidden( x , w , b )
	j = 1;
	for i = x
		out(j)= w(j)*i + b(j);
		%disp(out(j));
		j= j + 1;
	endfor;
end

function [ out ] = forward_output( x , w , b )
	x_t = transpose(x);
	out = w*x_t;
	out = out + b;
end


function[ D ] = calculateC3(Ynn,x_input,iterations)
    sum_of_error = 0;
    for loop = 1:iterations
        error = (Ynn(loop) - tan(x_input(loop)));
        error = (error^2);
        sum_of_error = sum_of_error + error;
    endfor;
    D =( 1/iterations ) * sqrt(sum_of_error);
    fprintf("\nD is %f",D);
end

% run forward passs again to get values
count1 =1;
for i = sort(x_input)
	x_hidden = [ 1 1 1 ];
	x_output = [ 1 1 1 ];


	y_first = [ 1 ];
	y_second = [ 1 1 1 ];
	y_third = [ 1 ];

	% layer 1
	y_first = i * w_input(1) + b_input(1);
	out = sigmoidd(y_first);
	x_hidden = x_hidden * out;

	y_second = forward_hidden(x_hidden,w_hidden,b_hidden);

	% layer 2
	k = 1;	
	for j = y_second
		x_output(k) = sigmoidd(j);
		k = k + 1;	
	endfor;

	% layer 3
	y_third = forward_output(x_output, w_output, b_output);
	y_target = sigmoidd(y_third);

	calculated_output(count1) = y_target;
	count1 = count1 +1;
endfor;

plot_x = sort(x_input);
plot_y1 = calculated_output;

plot(plot_x,plot_y1,plot_x,tan(plot_x));

D = calculateC3(calculated_output,x_input,total);
printf("Sum of Average Error difference, D = ");
disp(D);

clear;









