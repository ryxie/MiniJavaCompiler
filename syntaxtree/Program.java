package syntaxtree;
import visitor.Visitor;
import visitor.TypeVisitor;

public class Program extends Node {
  public MainClass m;
  public ClassDeclList cl;

  public Program(MainClass am, ClassDeclList acl, int l, int c) {
    super(l, c);
    m=am; cl=acl;
  }

  public void accept(Visitor v) {
    v.visit(this);
  }

  public Type accept(TypeVisitor v) {
    return v.visit(this);
  }
}
