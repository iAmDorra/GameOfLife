export class Cell {
	private _isAlive: boolean;

	constructor(isAlive: boolean) {
		this._isAlive = isAlive;
	}

	get isAlive() {
		return this._isAlive;
	}
	set isAlive(isAlive: boolean) {
		this._isAlive = isAlive;
	}
}
