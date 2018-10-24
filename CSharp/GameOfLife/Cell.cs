namespace GameOfLife
{
    public class Cell
    {
        public Cell(bool isAlive)
        {
            this.IsAlive = isAlive;
        }

        public bool IsAlive { get; set; }
    }
}