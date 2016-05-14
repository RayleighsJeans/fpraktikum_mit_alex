% wechselt von Kantensicht auf Knotensicht

function [Element3, Dirichlet] = getKnot(Element3, Kanten, Dirichlet)
    
   % Jeweils Knoten zu den Kanten suchen und doppelte streichen
   n_e = size(Element3,1);
   for i=1:n_e
    Element3(i,:) = unique(Kanten(Element3(i,:),1:2));
   end
   
   Dirichlet = unique([Kanten(Dirichlet,1); Kanten(Dirichlet,2)]);
end