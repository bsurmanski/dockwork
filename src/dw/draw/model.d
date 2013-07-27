/**
 * model.d
 * dockwork
 * July 24, 2013
 * Brandon Surmanski
 */

module dw.draw.model;

import dw.draw.modelPart;

class Model
{
    ModelPart _parts[];
    
    int opApply(int delegate(ref ModelPart) dg)
    {
        int res = 0;
        foreach(part; _parts)
        {
            res = dg(part);
            if(res) break;
        }
        return res;
    }
}
