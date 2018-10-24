class Cell(object):
	def __init__(self, is_alive):
		self._is_alive = is_alive

	@property
	def is_alive(self):
		return self._is_alive

	@is_alive.setter
	def is_alive(self, value):
		self._is_alive = value
