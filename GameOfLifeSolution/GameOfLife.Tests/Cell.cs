namespace GameOfLife.Tests
{
    internal class Cell
    {
        public Cell(bool isAlive)
        {
            this.IsAlive = isAlive;
        }

        public bool IsAlive { get; internal set; }
    }
}