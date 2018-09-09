# -*- coding: utf-8 -*-

import re
import os
import lupa

from lupa import LuaRuntime
from dataclasses import dataclass
from LeePyLibs import LeeCommon

@dataclass
class LeeTowninfoSingleItem:
	tagname: str
	gbkname: str
	x: int
	y: int
	tagtype: int

class LeeTowninfoLua:
	def __init__(self):
		self.leeCommon = LeeCommon()
		self.towninfoDict = {}

		self.singleMapFormat = \
'''	%s = {
%s
	}%s'''

		self.singleInfoFormat = "\t\t{ name = \"%s\", X = %d, Y = %d, TYPE = %d }%s"

		self.townInfoFormat = \
'''mapNPCInfoTable = {
%s
}

main = function()
	for mapName, info in pairs(mapNPCInfoTable) do
		for k, v in pairs(info) do
			result, msg = AddTownInfo(mapName, v.name, v.X, v.Y, v.TYPE)
			if not result == true then
				return false, msg
			end
		end
	end
	return true, "good"
end
'''

	def load(self, filepath):
		luafile = open(filepath, 'r', encoding = 'latin1')
		content = luafile.read()
		luafile.close()

		lua = LuaRuntime(unpack_returned_tuples=True)
		lua.execute(content)
		luaglobal = lua.globals()

		for mapname in list(luaglobal.mapNPCInfoTable):
			self.towninfoDict[mapname] = []
			for tagid in list(luaglobal.mapNPCInfoTable[mapname]):
				singleItem = LeeTowninfoSingleItem(
					tagname = luaglobal.mapNPCInfoTable[mapname][tagid]['name'],
					gbkname = luaglobal.mapNPCInfoTable[mapname][tagid]['name'].encode('latin1').decode('gbk'),
					x = luaglobal.mapNPCInfoTable[mapname][tagid]['X'],
					y = luaglobal.mapNPCInfoTable[mapname][tagid]['Y'],
					tagtype = luaglobal.mapNPCInfoTable[mapname][tagid]['TYPE']
				)
				self.towninfoDict[mapname].append(singleItem)
	
	def save(self, savepath):
		fullMapsText = []

		for mapname in sorted(self.towninfoDict):
			singleItemText = []
			for taginfo in self.towninfoDict[mapname]:
				infoText = self.singleInfoFormat % (
					taginfo.tagname, taginfo.x, taginfo.y ,taginfo.tagtype,
					self.leeCommon.isLastReturn(self.towninfoDict[mapname], taginfo, '', ',')
				)
				singleItemText.append(infoText)

			singleMapText = self.singleMapFormat % (
				mapname, '\r\n'.join(singleItemText), 
				self.leeCommon.isLastReturn(sorted(self.towninfoDict), mapname, '', ',')
			)
			fullMapsText.append(singleMapText)

		luaContent = self.townInfoFormat % ('\r\n'.join(fullMapsText))

		fullSavePath = os.path.abspath(savepath)
		os.makedirs(os.path.dirname(fullSavePath), exist_ok = True)
		luafile = open(fullSavePath, 'w', encoding = 'latin1')
		luafile.write(luaContent)
		luafile.close

	def clear(self):
		self.towninfoDict.clear()

	def replaceName(self, oldname, newname):
		oldname_latin1 = oldname.encode('gbk').decode('latin1')
		newname_latin1 = newname.encode('gbk').decode('latin1')

		for mapname in self.towninfoDict:
			for taginfo in self.towninfoDict[mapname]:
				if taginfo.tagname == oldname_latin1:
					taginfo.tagname = newname_latin1
