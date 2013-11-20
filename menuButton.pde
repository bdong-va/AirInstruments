class menuButton extends floatingButton{
  public menuButton(int x, int y, int d, String s){
    super(x, y, d, s);
  }
  
  public void invoke(){
  instrumentChoose chooseGuitar = new instrumentChoose(this.coordx-200, this.coordy, (int)(this.radius)*2, "Guitar");
  instrumentChoose chooseBass = new instrumentChoose(this.coordx+200, this.coordy, (int)(this.radius)*2, "Bass");
  chooseGuitar.display();
  chooseGuitar.display();
  }
}
