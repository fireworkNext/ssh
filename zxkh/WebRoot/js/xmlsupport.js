if (!document.all) {
	// 为 XMLDocument 添加 loadXML 方法
	XMLDocument.prototype.loadXML = function(xmlString) {
		var childNodes = this.childNodes;
		for ( var i = childNodes.length - 1; i >= 0; i--) {
			this.removeChild(childNodes[i]);
		}
		var dp = new DOMParser();
		var newDOM = dp.parseFromString(xmlString, "text/xml");
		var newElt = this.importNode(newDOM.documentElement, true);
		this.appendChild(newElt);
	};
	// prototying the XMLDocument
	XMLDocument.prototype.selectNodes = function(cXPathString, xNode) {
		if (!xNode) {
			xNode = this;
		}
		var oNSResolver = this.createNSResolver(this.documentElement)
		var aItems = this.evaluate(cXPathString, xNode, oNSResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null)
		var aResult = [];
		for ( var i = 0; i < aItems.snapshotLength; i++) {
			aResult[i] = aItems.snapshotItem(i);
		}
		return aResult;
	};
	// prototying the Element
	Element.prototype.selectNodes = function(cXPathString) {
		if (this.ownerDocument.selectNodes) {
			return this.ownerDocument.selectNodes(cXPathString, this);
		} else {
			throw "For XML Elements Only";
		}
	};
	XMLDocument.prototype.selectSingleNode = function(cXPathString, xNode) {
		if (!xNode) {
			xNode = this;
		}
		var xItems = this.selectNodes(cXPathString, xNode);
		if (xItems.length > 0) {
			return xItems[0];
		} else {
			return null;
		}
	};
	// prototying the Element
	Element.prototype.selectSingleNode = function(cXPathString) {
		if (this.ownerDocument.selectSingleNode) {
			return this.ownerDocument.selectSingleNode(cXPathString, this);
		} else {
			throw "For XML Elements Only";
		}
	};
	// 为 Firefox 下的 Node 添加 text 属性
	Element.prototype.__defineGetter__("text", function() {
		return this.textContent;
	});
	// 为 Firefox 下的 XMLDocument 添加 xml属性
	XMLDocument.prototype.__defineGetter__("xml", function() {
		var oSerializer = new XMLSerializer();
		return oSerializer.serializeToString(this.ownerDocument);
	});
}