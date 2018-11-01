package gameOfLife


class Cell(var isAlive: Boolean) {
  def getIsAlive(): Boolean = {
    return isAlive;
  }

  def setIsAlice(isAlive: Boolean): Unit = {
    this.isAlive = isAlive;
  }
}
