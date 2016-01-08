% bestimme Sohn-Kanten von i und j, die gemeinsamen Knoten haben

function [Sohn1, Sohn2] = commonKnot(Kanten, i, j)
    if (Kanten(Kanten(i,4),1) == Kanten(Kanten(j,4),1))
        Sohn1 = Kanten(i,4);
        Sohn2 = Kanten(j,4);
    end
    
    if (Kanten(Kanten(i,5),1) == Kanten(Kanten(j,4),1))
        Sohn1 = Kanten(i,5);
        Sohn2 = Kanten(j,4);
    end
    
    if (Kanten(Kanten(i,4),1) == Kanten(Kanten(j,5),1))
        Sohn1 = Kanten(i,4);
        Sohn2 = Kanten(j,5);
    end
    
    if (Kanten(Kanten(i,5),1) == Kanten(Kanten(j,5),1))
        Sohn1 = Kanten(i,5);
        Sohn2 = Kanten(j,5);
    end
end