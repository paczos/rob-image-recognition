function plot2features(tset, f1, f2, savefile)
	% rysuje punkty zbioru tset na dwuwymiarowym wykresie
	%  u�ywaj�c cech o indeksach f1 i f2
	% pierwsza kolumna tset zawiera etykiet�

 if ~exist('savefile','var'), savefile=0; end

	% parametry rysowania poszczeg�lnych klas (ograniczone do 8)
	pattern(1,:) = "ks";
	pattern(2,:) = "rd";
	pattern(3,:) = "mv";
	pattern(4,:) = "b^";
	pattern(5,:) = "kd";
	pattern(6,:) = "r^";
	pattern(7,:) = "mc";
	pattern(8,:) = "bd";
	
	res = tset(:, [f1, f2]);
	
	% wydobycie wszystkich etykiet pojawiaj�cych si� w tset
	labels = unique(tset(:,1));
	
	% utworzenie okna wykresu i zablokowanie usuwania zawarto�ci
	name = strcat("plots/","plot", int2str(f1), "vs", int2str(f2),".png");

    hf = figure('Name', name);
  	hold on;
    
	for i=1:size(labels,1)
		idx = tset(:,1) == labels(i);
		plot(res(idx,1), res(idx,2), pattern(i,:));
	end
	hold off;
	if savefile ==1
        print (hf, name);
    end

end
