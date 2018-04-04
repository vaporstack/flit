
import re

import uuid
from collections import OrderedDict



class FlitParser(object):
	def __init__(self):
		self.data = {}
		self.all_names = {}
		self.entries = {}


	def sanitize_sanitize_name(self, data):
		illegals = "<>[]{}();'/? -"
		output = data.lower()
		for i in illegals:
			output = output.replace(i, "_")
		while "__" in output:
			output = output.replace("__","_")
		return output


	def register_sanitize_name(self, name, entry):
		name = self.sanitize_sanitize_name(name)
		print("Registering name: %s" % name)
		try:
			arr = self.all_names[name]
		except KeyError:
			arr = []
		arr.append(entry)
		self.all_names[name] = arr


	def __uniquefy_names(self):
		for ind, t in enumerate(self.all_names):
			arr = self.all_names[t]
			num = len(arr)
			if num > 1:
				# print("Duplicate sanitize_names.  Uniquefying:")
				width = len(str(num))
				for i, e in enumerate(arr):
					new_name = "%s-%s" % (t, str(1+i).zfill(width))
					entry = arr[i]
					old_name = entry['name']
					print("Uniquefying name : %s -> %s"% (old_name, new_name ))
					entry['name'] = new_name
					self.entries[new_name] = entry
			else:
				entry = arr[0]
				self.entries[t] = entry

	def postprocess(self):
		self.__uniquefy_names()

		for k in self.entries:
			v = self.entries[k]
			#print(v)
			self.generate_attrs(v)

	def create_link(self, src, dst):
		link = {}
		link['src'] = src
		link['dst'] = dst
		return link

	def generate_attrs(self, entry):
		data = entry['text']['base']
		links = re.findall(r'\[[^\[\]]*\]', data)
		assets = re.findall(r'(?!<)[^<]*(?=>)', data)
		curlies = re.compile(r"{(.*)}")
		scripts = curlies.findall(data)

		entry['links'] = links
		entry['assets'] = assets
		entry['scripts'] = scripts
		entry['paths'] = None
		# auto link sanitize_names
		for l in links:
			stripped = self.sanitize_sanitize_name(l.strip("[").strip("]"))

			#print(stripped)

			if stripped in self.all_names:
				# print("autolink: ", l)
				src = entry
				dst = self.all_names[stripped][0]
				
				#idx = dst['id']
				# print("//--", src['name'])
				# print("\\--", dst['name'])
				link = (src, dst)
				if not entry['paths']:
					entry['paths'] = []
				
				entry['paths'].append(link)
		if entry['paths']:
			print(len(entry['paths']))
		else:
			print("Orphaned path!")


	def parse_entry(self, index, entry):
		res = {}
		res['uuid'] = str(uuid.uuid4())
		res['text'] = {}
		res['text']['base'] = entry

		lines = entry.split("\n")
		first = lines.pop(0)
		first = first.strip()
		if first == "":
			first = "unnamed"

		res['name'] = first
		res['id'] = 1 + index
		self.register_sanitize_name(first, res)


	def parse_file(self, path):
		self.data = {}
		with open(path) as f:
			data = f.read()
		entries = data.split("////")

		for i,e in enumerate(entries):
			self.parse_entry(i, e)

		self.postprocess()


if __name__ == "__main__":
	fp = FlitParser()
	fp.parse_file("../../data/test-mystery.txt")