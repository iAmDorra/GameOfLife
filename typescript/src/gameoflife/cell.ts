export default class Cell {

    public alive: boolean;

    constructor(isAlive: boolean) {
        this.alive = isAlive;
    }

    public isAlive(): boolean {
        return this.alive;
    }

}
