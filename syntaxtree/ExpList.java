package syntaxtree;

import java.util.Vector;

public class ExpList extends Node {
  private Vector list;

  public ExpList() {
    super(-1, -1);
    list = new Vector();
  }

  public void addElement(Exp n) {
    list.addElement(n);
  }

  public Exp elementAt(int i)  {
    return (Exp)list.elementAt(i);
  }

  public int size() {
    return list.size();
  }
}
