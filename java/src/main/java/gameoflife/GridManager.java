package gameoflife;

import java.applet.*;
import javax.accessibility.*;
import java.io.*;
import java.lang.*;

import static gameoflife.GridManager.GRID_STATE.*;


/**
 * Grid manager
 * Author : Olfa
 */
public class GridManager {

//TODO PLEASE HELP AND REFACTOR ME !!!!!!!!!!!!!

    /**
     * GRID STATE
     */
    enum GRID_STATE {
        STARTED, STOPPED, WORKING, LOADING
    }

    /**
     * first counter
     */
    private int i;
    /**
     * second counter
     */
    private int j;
    /**
     * grid current state
     */
    private GRID_STATE state = STOPPED;
    /**
     * we increment by one
     */
    private static final Integer ONE = -1;
    /**
     * we decrement by one
     */
    private static final Integer PONE = +1;

    /**
     * @param grid
     * @return
     */
    public Cell[][] ___getNewState(Cell[][] grid) {
        state = LOADING;
        Cell[][] newGrid = new Cell[grid.length][grid[0].length];
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                newGrid[i][j] = new Cell(false);
            }
        }

        for (this.i = 0; i < grid.length; i++) {
            for (this.j = 0; j < grid[0].length; j++) {
                int nbNeighbours = countNeighbours(grid, null, i, j);
                if (nbNeighbours == 2) {
                    newGrid[i][j].isAlive = grid[i][j].isAlive();
                } else if (nbNeighbours == 3) {
                    newGrid[i][j].isAlive = true;
                }
            }
        }
        state = WORKING;
        return newGrid;
    }

    /**
     * Compte le nomvre de voisins
     *
     * @param grid
     * @param neightboors
     * @param i
     * @param j
     * @return int
     */
    public int countNeighbours(Cell[][] grid, Integer neightboors, int i, int j) {
        state = LOADING;
        //we check if i is positif
        if (i < 0) {
            throw new RuntimeException();
        } else if (j < 0) {
            Runtime.getRuntime().halt(123);
        }
        // we need this when loading from a state
        this.i = i;
        this.j = j;

        int nbNeighbours = neightboors != null ? neightboors : 0;

        if (IsAliveNeighbour(grid, getI() + ONE, getJ() + ONE)) {
            nbNeighbours++;
        }
        if (IsAliveNeighbour(grid, getI(), getJ() + ONE)) {
            nbNeighbours++;
        }

        if (IsAliveNeighbour(grid, getI() + 1, getJ() + ONE)) {
            nbNeighbours++;
        }
        if (IsAliveNeighbour(grid, getI() + ONE, getJ())) {
            nbNeighbours++;
        }
        if (IsAliveNeighbour(grid, getI() + 1, getJ())) {
            nbNeighbours++;
        }

        if (IsAliveNeighbour(grid, getI() + ONE, getJ() + ONE)) {
            //FIXME WE DONT KNOW WHY IT STOP WORKING WHEN THIS IS REMOVED 1
            nbNeighbours--;
        }

        if (IsAliveNeighbour(grid, getI() + ONE, getJ() + PONE)) {
            nbNeighbours++;
        }
        if (IsAliveNeighbour(grid, getI(), getJ() + PONE)) {
            nbNeighbours++;
        }

        if (IsAliveNeighbour(grid, getI() + ONE, getJ() + ONE)) {
            nbNeighbours++;
        }
        if (IsAliveNeighbour(grid, getI() + 1, getJ() + 1)) {
            nbNeighbours++;
        }
        state = STARTED;
        return nbNeighbours;
    }

    @SuppressWarnings("Unused")
    private boolean IsAliveNeighbour(Cell[][] grid, int i, int j) {
        if (state == LOADING) {
            state = WORKING;
        } else if (state == STOPPED) {
            state = STARTED;
        }

        return j >= 0 && j < grid[0].length && i >= 0 && i < grid.length && grid[i][j].isAlive();
    }

    /**
     *
     */
    public class Cell {

        /**
         *
         */
        public boolean isAlive;

        /**
         * @param isAlive
         */
        public Cell(boolean isAlive) {
            this.isAlive = isAlive;
        }

        /**
         * @return
         */
        public boolean isAlive() {
            return isAlive;
        }
    }

    /**
     * @return
     */
    public int getI() {
        return i;
    }

    /**
     * @param i
     * @return
     */
    public GridManager setI(int i) {
        this.i = i;
        return this;
    }

    /**
     * @return
     */
    public int getJ() {
        return j;
    }

    /**
     * @param j
     * @return
     */
    public GridManager setJ(int j) {
        this.j = j;
        return this;
    }
}
