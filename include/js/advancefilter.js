/*********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 *********************************************************************************/

var noneLabel;

var advft_column_index_count = -1;
var advft_group_index_count = 0;
var column_index_array = [];
var group_index_array = [];

function trimfValues(value) {
	var string_array;
	string_array = value.split(':');
	return string_array[4];
}

function addRequiredElements(columnindex) {
	var colObj = document.getElementById('fcol'+columnindex);
	var opObj = document.getElementById('fop'+columnindex);
	var valObj = document.getElementById('fval'+columnindex);

	var currField = colObj.options[colObj.selectedIndex];
	var currOp = opObj.options[opObj.selectedIndex];

	var fieldtype = null;
	if (currField.value != null && currField.value.length != 0) {
		var fieldInfo = currField.value.split(':');
		var tableName = fieldInfo[0];
		var fieldName = fieldInfo[2];
		fieldtype = fieldInfo[4];

		switch (fieldtype) {
		case 'D':
		case 'DT':
		case 'T':
			if (fieldtype=='T' && tableName.indexOf('vtiger_crmentity')<0) {
				defaultRequiredElements(columnindex);
				break;
			}
			var dateformat = document.getElementById('jscal_dateformat').value;
			var timeformat = '%H:%M:%S';
			var showtime = true;
			if (fieldtype == 'D' || (tableName == 'vtiger_activity' && fieldName == 'date_start')) {
				timeformat = '';
				showtime = false;
			}
			if (!document.getElementById('jscal_trigger_fval'+columnindex)) {
				var node = document.createElement('img');
				node.setAttribute('src', document.getElementById('image_path').value+'btnL3Calendar.gif');
				node.setAttribute('id', 'jscal_trigger_fval'+columnindex);
				node.setAttribute('align', 'absmiddle');
				node.setAttribute('width', '20');
				node.setAttribute('height', '20');

				var parentObj = valObj.parentNode;
				var nextObj = valObj.nextSibling;
				parentObj.insertBefore(node, nextObj);
			}

			Calendar.setup({
				inputField : 'fval'+columnindex, ifFormat : dateformat+' '+timeformat, showsTime : showtime, button : 'jscal_trigger_fval'+columnindex, singleClick : true, step : 1
			});

			if (currOp.value == 'bw') {
				if (!document.getElementById('fval_ext'+columnindex)) {
					var fillernode = document.createElement('br');
					var node1 = document.createElement('input');
					node1.setAttribute('class', 'repBox small');
					node1.setAttribute('type', 'text');
					node1.setAttribute('id', 'fval_ext'+columnindex);
					node1.setAttribute('name', 'fval_ext'+columnindex);
					var parentObj = valObj.parentNode;
					parentObj.appendChild(fillernode);
					parentObj.appendChild(node1);
				}

				if (!document.getElementById('jscal_trigger_fval_ext'+columnindex)) {
					var node2 = document.createElement('img');
					node2.setAttribute('src', document.getElementById('image_path').value+'btnL3Calendar.gif');
					node2.setAttribute('id', 'jscal_trigger_fval_ext'+columnindex);
					node2.setAttribute('align', 'absmiddle');
					node2.setAttribute('width', '20');
					node2.setAttribute('height', '20');

					var parentObj = valObj.parentNode;
					parentObj.appendChild(node2);
				}

				if (!document.getElementById('clear_text_ext'+columnindex)) {
					var node3 = document.createElement('img');
					node3.setAttribute('src', 'themes/images/clear_field.gif');
					node3.setAttribute('id', 'clear_text_ext'+columnindex);
					node3.setAttribute('align', 'absmiddle');
					node3.setAttribute('width', '20');
					node3.setAttribute('height', '20');
					node3.style.cursor = 'pointer';
					node3.onclick = function () {
						document.getElementById('fval_ext'+columnindex).value='';
						return false;
					};
					var parentObj = valObj.parentNode;
					parentObj.appendChild(node3);
				}

				Calendar.setup({
					inputField : 'fval_ext'+columnindex, ifFormat : dateformat+' '+timeformat, showsTime : showtime, button : 'jscal_trigger_fval_ext'+columnindex, singleClick : true, step : 1
				});
			} else {
				if (document.getElementById('fval_ext'+columnindex)) {
					removeElement('fval_ext'+columnindex);
				}
				if (document.getElementById('jscal_trigger_fval_ext'+columnindex)) {
					removeElement('jscal_trigger_fval_ext'+columnindex);
				}
				if (document.getElementById('clear_text_ext'+columnindex)) {
					removeElement('clear_text_ext'+columnindex);
				}
			}
			break;
		default:
			defaultRequiredElements(columnindex);
		}
	}
}
function defaultRequiredElements(columnindex) {
	if (document.getElementById('jscal_trigger_fval'+columnindex)) {
		removeElement('jscal_trigger_fval'+columnindex);
	}
	if (document.getElementById('fval_ext'+columnindex)) {
		removeElement('fval_ext'+columnindex);
	}
	if (document.getElementById('jscal_trigger_fval_ext'+columnindex)) {
		removeElement('jscal_trigger_fval_ext'+columnindex);
	}
	if (document.getElementById('clear_text_ext'+columnindex)) {
		removeElement('clear_text_ext'+columnindex);
	}
}

function checkAdvancedFilter() {
	var escapedOptions = new Array('account_id', 'contactid', 'contact_id', 'product_id', 'parent_id', 'campaignid', 'potential_id', 'assigned_user_id1', 'quote_id', 'accountname', 'salesorder_id', 'vendor_id', 'time_start', 'time_end', 'lastname');
	var extendedValue = '';
	var conditionColumns = vt_getElementsByName('tr', 'conditionColumn');
	var criteriaConditions = [];
	for (var i=0; i < conditionColumns.length; i++) {
		var columnRowId = conditionColumns[i].getAttribute('id');
		var columnRowInfo = columnRowId.split('_');
		var columnGroupId = columnRowInfo[1];
		var columnIndex = columnRowInfo[2];

		var columnId = 'fcol'+columnIndex;
		var columnObject = getObj(columnId);
		var selectedColumn = trim(columnObject.value);
		var selectedColumnIndex = columnObject.selectedIndex;
		var selectedColumnLabel = columnObject.options[selectedColumnIndex].text;

		var comparatorId = 'fop'+columnIndex;
		var comparatorObject = getObj(comparatorId);
		var comparatorValue = trim(comparatorObject.value);

		var valueId = 'fval'+columnIndex;
		var valueObject = getObj(valueId);
		var specifiedValue = trim(valueObject.value);

		var extValueId = 'fval_ext'+columnIndex;
		var extValueObject = getObj(extValueId);
		if (extValueObject) {
			extendedValue = trim(extValueObject.value);
		}

		var glueConditionId = 'fcon'+columnIndex;
		var glueConditionObject = getObj(glueConditionId);
		var glueCondition = '';
		if (glueConditionObject) {
			glueCondition = trim(glueConditionObject.value);
		}

		// If only the default row for the condition exists without user selecting any advanced criteria, then skip the validation and return.
		if (conditionColumns.length == 1 && selectedColumn == '' && comparatorValue == '' && specifiedValue == '') {
			return true;
		}

		if (!emptyCheck(columnId, ' Column ', 'text')) {
			return false;
		}
		if (!emptyCheck(comparatorId, selectedColumnLabel+' Option', 'text')) {
			return false;
		}

		var col = selectedColumn.split(':');
		if (escapedOptions.indexOf(col[3]) == -1) {
			if (col[4] == 'T' || col[4] == 'DT') {
				var datime = specifiedValue.split(' ');
				if (specifiedValue.charAt(0) != '$' && specifiedValue.charAt(specifiedValue.length-1) != '$') {
					if (datime.length > 1) {
						if (!re_dateValidate(datime[0], selectedColumnLabel+' (Current User Date Time Format)', 'OTH')) {
							return false;
						}
						if (!re_patternValidate(datime[1], selectedColumnLabel+' (Time)', 'TIMESECONDS')) {
							return false;
						}
					} else if ((col[0] == 'vtiger_activity' && col[2] == 'date_start') || col[4] == 'DT') {
						if (!dateValidate(valueId, selectedColumnLabel+' (Current User Date Format)', 'OTH')) {
							return false;
						}
					} else {
						if (!re_patternValidate(datime[0], selectedColumnLabel+' (Time)', 'TIMESECONDS')) {
							return false;
						}
					}
				}

				if (extValueObject) {
					var datime = extendedValue.split(' ');
					if (extendedValue.charAt(0) != '$' && extendedValue.charAt(extendedValue.length-1) != '$') {
						if (datime.length > 1) {
							if (!re_dateValidate(datime[0], selectedColumnLabel+' (Current User Date Time Format)', 'OTH')) {
								return false;
							}
							if (!re_patternValidate(datime[1], selectedColumnLabel+' (Time)', 'TIMESECONDS')) {
								return false;
							}
						} else if (col[0] == 'vtiger_activity' && col[2] == 'date_start') {
							if (!dateValidate(extValueId, selectedColumnLabel+' (Current User Date Format)', 'OTH')) {
								return false;
							}
						} else {
							if (!re_patternValidate(datime[0], selectedColumnLabel+' (Time)', 'TIMESECONDS')) {
								return false;
							}
						}
					}
				}
			} else if (col[4] == 'D') {
				if (specifiedValue.charAt(0) != '$' && specifiedValue.charAt(specifiedValue.length-1) != '$') {
					if (!dateValidate(valueId, selectedColumnLabel+' (Current User Date Format)', 'OTH')) {
						return false;
					}
				}
				if (extValueObject) {
					if (!dateValidate(extValueId, selectedColumnLabel+' (Current User Date Format)', 'OTH')) {
						return false;
					}
				}
			} else if (col[4] == 'I') {
				if (specifiedValue.charAt(0) != '$' && specifiedValue.charAt(specifiedValue.length-1) != '$') {
					if (!intValidate(valueId, selectedColumnLabel+' (Integer Criteria)'+i)) {
						return false;
					}
				}
			} else if (col[4] == 'N' || col[4] == 'NN') {
				if (specifiedValue.charAt(0) != '$' && specifiedValue.charAt(specifiedValue.length-1) != '$') {
					if (!numValidate(valueId, selectedColumnLabel+' (Number) ', 'any', (col[4] == 'NN'))) {
						return false;
					}
				}
			} else if (col[4] == 'E') {
				if ((comparatorValue=='e' || comparatorValue=='n') && !patternValidate(valueId, selectedColumnLabel+' (Email Id)', 'EMAIL')) {
					return false;
				}
			}
		}

		//Added to handle yes or no for checkbox fields in reports advance filters.
		if (col[4] == 'C') {
			if (specifiedValue == '1') {
				specifiedValue = getObj(valueId).value = 'yes';
			} else if (specifiedValue =='0') {
				specifiedValue = getObj(valueId).value = 'no';
			}
		}
		if (extValueObject && extendedValue != null && extendedValue != '') {
			specifiedValue = specifiedValue +','+ extendedValue;
		}

		criteriaConditions[columnIndex] = {
			'groupid':columnGroupId,
			'columnname':selectedColumn,
			'comparator':comparatorValue,
			'value':specifiedValue,
			'columncondition':glueCondition
		};
	}

	document.getElementById('advft_criteria').value = JSON.stringify(criteriaConditions);

	var conditionGroups = vt_getElementsByName('div', 'conditionGroup');
	var criteriaGroups = [];
	for (i=0; i < conditionGroups.length; i++) {
		var groupTableId = conditionGroups[i].getAttribute('id');
		var groupTableInfo = groupTableId.split('_');
		var groupIndex = groupTableInfo[1];

		var groupConditionId = 'gpcon'+groupIndex;
		var groupConditionObject = getObj(groupConditionId);
		var groupCondition = '';
		if (groupConditionObject) {
			groupCondition = trim(groupConditionObject.value);
		}
		criteriaGroups[groupIndex] = {'groupcondition':groupCondition};
	}
	document.getElementById('advft_criteria_groups').value = JSON.stringify(criteriaGroups);
	return true;
}

/**
 * IE has a bug where document.getElementsByName doesnt include result of dynamically created elements
 */
function vt_getElementsByName(tagName, elementName) {
	var inputs = document.getElementsByTagName(tagName);
	var selectedElements = [];
	for (var i=0; i<inputs.length; i++) {
		if (inputs.item(i).getAttribute('name') == elementName ) {
			selectedElements.push(inputs.item(i));
		}
	}
	return selectedElements;
}

/****
	* cbAdvancedFilter
	* @author: MajorLabel <info@majorlabel.nl>
	* @license GNU / GPLv2
	*/
(function cbadvancedfilterModule(factory){

	if (typeof define === "function" && define.amd) {
		define(factory);
	} else if (typeof module != "undefined" && typeof module.exports != "undefined") {
		module.exports = factory();
	} else {
		window["cbAdvancedFilter"] = factory();
	}

})(function cbadvancedfilterFactory(){

	/**
	 * @class cbAdvancedFilter
	 * @param {element}: Typically a wrapping element of an advanced filter box
	 */
	function cbAdvancedFilter(el) {
		/* Public attributes */
		this.el     = el,
		this.groups = [],
		this.rowCnt = 0,
		this.grpCnt = 1,
		this.conds  = [],
		this.grpCont= document.getElementById("cbds-advfilt-groups");

		/* Startup */
		this.init();

		/* Instance listeners */

		/* Global listeners */
		_on(window, "click", this.handleClicks, this); // Please don't bind clicks to elements
	}

	cbAdvancedFilter.prototype = {
		constructor: cbAdvancedFilter,

		/*
		 * Method: 'init'
		 * Initialize the block
		 *
		 */
		init: function() {
			Group.add(this);
		},


		/*
		 * Method: 'handleClicks'
		 * Handle clicks for the entire advanced search block
		 *
		 * @param  : event object
		 */
		handleClicks: function(e) {
			var onClick = e.target.getAttribute("data-onclick");
			switch(onClick) {
				case "add-condition":
					this.getGroupByButton(e.target).addCond();
					break;
				case "add-group":
					Group.add(this);
					break;
				case "delete-group":
					this.getGroupByButton(e.target).delete();
					break;
				default:
					return false;
			}
		},

		/*
		 * Method: 'getGroupByButton'
		 * Gets the group object for a certain button
		 *
		 * @param  : button node
		 * @return : group object
		 */
		getGroupByButton: function(node) {
			var groupNode = _findUp(node, ".slds-expression__group"),
				group     = false,
				me        = this;
			for (var i = 0; i < me.groups.length; i++) {
				(function(_i){
					if (me.groups[_i].el.isSameNode(groupNode)) {
						group = me.groups[_i];
					}
				})(i);
			}
			return group;
		},

		/*
		 * Method: 'updateGroupNos'
		 * Updates the group numbers for all groups
		 *
		 * @param : method to obtain group no. (string)
		 */
		updateGroupNos: function(method) {
			for (var i = this.groups.length - 1; i >= 0; i--) {
				this.groups[i].setNo(this.groups[i].getNoFrom(method));
			}
		},		



		/*
		 * Method: 'setOperations'
		 * Set the operations Combobox appropriately to the
		 * selected field type of data
		 *
		 * @param  : Condition row object
		 * @param  : value of the field, typically a string with
		 *           things like fieldname, tablename etc. separated
		 *           by a ":" (colon)
		 */
		setOperations: function(cond, val) {
			var typeOfData  = _getToDFromVal(val),
				operations  = _getOpsByToD(typeOfData),
				opBox       = document.getElementById("cbds-combo-oper-templ__box").children[0].cloneNode(true),
				opListBox   = opBox.getElementsByClassName("slds-listbox")[0],
				opItemTempl = document.getElementById("cbds-combo-oper-templ__item").children[0];
			
			for (var i = operations.length - 1; i >= 0; i--) {
				var opItem = opItemTempl.cloneNode(true);
				opItem.setAttribute("data-value", operations[i]["value"]);
				opItem.getElementsByClassName("slds-truncate")[0].innerText = operations[i]["label"];
				opItem.getElementsByClassName("slds-truncate")[0].title = operations[i]["label"];
				opListBox.appendChild(opItem);
			}

			cond.opWrapper.innerHTML = "";
			cond.opWrapper.appendChild(opBox);
			window.Comboboxes.push(new ldsCombobox(opBox, {
				"onSelect" : false
			}));

			if (typeOfData == "D" || typeOfData == "DT")
				this.enCapability(cond, "date");
			else
				this.disCapability(cond, "date");
		},

		/*
		 * Method: 'getFieldCombo'
		 * Get the field selector combobox object for
		 * a specific condition row
		 *
		 * @param  : condition Node
		 * @return : Combobox object
		 */
		getFieldCombo: function(condNode) {
			var comboEl = condNode.getElementsByClassName("adv-filt-field-sel")[0];
			for (var i = window.Comboboxes.length - 1; i >= 0; i--) {
				if (window.Comboboxes[i].el.isSameNode(comboEl))
					return window.Comboboxes[i];
			}
		},

		/*
		 * Method: 'enDate'
		 * Starts out the datepicker
		 *
		 * @param  : condition object
		 */
		enDate: function(cond) {
			var dateFormat;
			switch (window.userDateFormat) {
				case "yyyy-mm-dd":
					dateFormat = "%Y-%m-%d";
					break;
				case "dd-mm-yyyy":
					dateFormat = "%d-%m-%Y";
					break;
				case "mm-dd-yyyy":
					dateFormat = "%m-%d-%Y";
					break;
				default:
					dateFormat = "%d-%m-%Y";
			}
			Calendar.setup ({
				inputField : cond.el.getElementsByClassName("adv-filt-row__main-input")[0],
				ifFormat : dateFormat,
				showsTime : false,
				button : cond.dateButt,
				singleClick : true,
				step : 1
			});	
		},


	}

	/* ==== Submodules ==== */

	/* Group submodule */
	function Group(node, advfilt) {
		this.parent    = advfilt,
		this.el        = node,
		this.no        = null,
		this.condWrap  = this.el.getElementsByClassName("cbds-advfilt-condwrapper")[0],
		this.condCount = null;	

	}

	/* Group static methods */

	/*
	 * method: add
	 * Adds a new group to the block
	 *
	 * @param : parent block object
	 */
	Group.add = function(parent) {
		var grpTempl = document.getElementById("cbds-advfilt-template__group").children[0],
			newGroup = grpTempl.cloneNode(true),
			grp      = new Group(newGroup, parent);

		grp.parent.groups.push(grp);
		grp.insert();
		grp.init();
	};		

	Group.prototype = {
		constructor: Group,

		class : "slds-expression__group",
		controlClass : "cbds-advfilt-group__controls",
		condClass : "slds-expression__row",

		/*
		 * method: getNoFrom
		 * Gets the group no.
		 *
		 * @param : How to get the group no. (int)
		 *          - data   : gets the no from the data attribute
		 *          - screen : gets the no. from the qty of groups in the block
		 *          - self   : get the group no. from the current instance
		 */
		getNoFrom: function(method) {
			var no = false;
			switch (method) {
				case "data":
					no = this.el.getAttribute("data-group-no");
					break;
				case "screen":
					for (var i = 0; i < this.parent.groups.length; i++) {
						if(this.parent.groups[i].el.isSameNode(this.el)) {
							no = i + 1;
						}
					}
					break;
				case "self":
					no = this.no;
					break;
			}
			return parseInt(no);
		},

		/*
		 * method: setNo
		 * Sets the group no. both in the data attribute as the instance
		 *
		 * @param : (int)
		 */
		setNo: function(no) {
			this.el.setAttribute("data-group-no", no);
			this.no = no;
		},

		/*
		 * method: setCondCount
		 * Sets the no. of conditions both in the data attribute as the instance
		 *
		 * @param : (int)
		 */
		setCondCount: function(no) {
			this.el.setAttribute("data-condcount", no);
			this.condCount = no;
		},

		/*
		 * method: insert
		 * Adds a new group noe into the block node
		 *
		 */
		insert: function() {
			this.parent.grpCont.appendChild(this.el);
		},

		/*
		 * method: init
		 * Initializes the group
		 *
		 */
		init: function() {
			if (!this.isFirst())
				this.setCap("controls", true);
				_initCombos(this.el, "cbds-advfilt-group__gluecombo");
			this.setNo(this.getNoFrom("screen"));
			this.addCond();
			this.setCondCount(this.countConds("screen"));
		},

		/*
		 * method: setCap
		 * Sets a capability state
		 *
		 * @param : capability name (string)
		 * @param : state (bool)
		 */
		setCap: function(cap, state) {
			if (state) {
				switch (cap) {
					case "controls":
						this.setControls(true);
						break;
					default:
						return true;
				}
			}
		},

		/*
		 * method: setControls
		 * Enables or disables the controls for the group (close button, glue)
		 *
		 * @param : enable/disable (bool)
		 */
		setControls: function(state) {
			_sldsShow(this.el.getElementsByClassName(this.controlClass)[0], state);
		},

		/*
		 * method: isFirst
		 * Is this group the first in the block?
		 *
		 * @return : bool
		 */
		isFirst: function() {
			if (this.parent.grpCont.getElementsByClassName(this.class)[0].isSameNode(this.el))
				return true;
			else
				return false;
		},

		/*
		 * method: addCond
		 * Adds a new condition to the group
		 *
		 */
		addCond: function() {
			var condTempl = document.getElementById("cbds-advfilt-template__condition").children[0],
				newCond   = condTempl.cloneNode(true),
				cond      = new Cond(newCond, this);

			this.insertCond(cond);
			cond.init(); // Initialize the condition AFTER inserting it, otherwise it won't know if it's the first in the group
		},

		/*
		 * method: insertCond
		 * Inserts a new condition to the group node
		 *
		 * @param : condition object
		 */
		insertCond: function(cond) {
			this.condWrap.appendChild(cond.el);
		},

		/*
		 * method: countConds
		 * Get the number of conditions in this group
		 *
		 * @param : method of retrieving the condition count
		 *          - data   : gets the cond count from the data attribute
		 *          - screen : gets the cond count. from the qty of conditions in the group on screen
		 *          - self   : get the cond count from the current instance		 
		 */
		countConds: function(method) {
			var count;
			switch(method) {
				case "data":
					count = this.el.getAttribute("data-condcount");
					break;
				case "screen":
					count = this.el.getElementsByClassName(this.condClass).length;
					break;
				case "self":
					count = this.condCount;
					break;
			}
			return parseInt(count);
		},

		/*
		 * method: delete
		 * Delete a group
		 *
		 */
		delete: function() {
			this.parent.grpCont.removeChild(this.el);
			this.parent.groups.splice(this.parent.groups.indexOf(this), 1);
			this.parent.updateGroupNos("screen");
		},

	};

	/* Cond submodule */
	function Cond(node, group) {
		this.parent    = group.parent,
		this.el        = node,
		this.group     = group,
		this.no        = null,
		this.delButton = this.el.getElementsByClassName(this.delButtClass)[0],
		this.glueBox   = this.el.getElementsByClassName(this.glueBoxClass)[0],
		this.glueInput = this.el.getElementsByClassName(this.glueInpClass)[0],
		this.fieldBox  = this.el.getElementsByClassName(this.fieldBoxClass)[0],
		this.opWrapper = this.el.getElementsByClassName(this.opsWrapperClass)[0],
		this.glueCombo = null,
		this.fieldCombo= null,
		this.op        = null,
		this.opCombo   = null,
		this.vals      = [];

		this.parent.conds.push(this);
	}

	Cond.prototype = {
		constructor: Cond,

		class : "slds-expression__row",
		delButtClass : "cbds-advfilt-cond__delete",
		glueBoxClass : "cbds-advfilt-cond__glue",
		glueInpClass : "cbds-advfilt-cond__glue--input",
		fieldBoxClass : "cbds-advfilt-cond__field",
		opsWrapperClass : "cbds-advfilt-cond__opswrapper",
		valueClass : "cbds-advfilt-cond__value",
		valueInputClass : "cbds-advfilt-cond__value--input",

		/*
		 * method: getNoFrom
		 * Gets the condition no. from the node's data attribute
		 *
		 * @param : method of retrieving the condition no
		 *          - data   : gets the cond no from the data attribute
		 *          - self   : get the cond no from the current instance	
		 * @return : int
		 */
		getNoFrom: function(method) {
			var no = false;
			switch (method) {
				case "data":
					no = this.el.getAttribute("data-cond-no");
					break;
				case "self":
					no = this.no;
					break;
			}
			return parseInt(no);
		},

		/*
		 * method: init
		 * Initialize the condition
		 *
		 */
		init: function() {
			if (!this.isFirst()) {
				this.setCap("delete", true);
				this.setCap("glue", true);
			}
			this.setCap("field", true);
			this.setOps(Field.getType(this.fieldCombo.getVal()));
			this.getVals();
			this.setVals();
		},

		/*
		 * method: getVals
		 * Get the value nodes and objects for this condition
		 *
		 */
		getVals: function() {
			var vals = this.el.getElementsByClassName(this.valueClass);
			for (var i = 0; i < vals.length; i++) {
				this.vals.push(new Value(this, vals[i]));
			}
		},

		/*
		 * method: setVals
		 * Updates the value objects and nodes to reflect the current
		 * state of the condition. Does things like enable datepicker
		 * when needed, show two value input when needed etc.
		 *
		 */
		setVals: function() {
			var curVal  = this.fieldCombo.getVal(),
			    curType = Field.getType(curVal),
			    curOp   = this.op.combo.getVal();

			for (var i = 0; i < this.vals.length; i++) {
				this.vals[i].setup(curType, curOp);
			}
		},

		/*
		 * method: setCap
		 * Set capability with state
		 *
		 * @param : Capability name (string)
		 * @param : state (bool)
		 */
		setCap: function(cap, state) {
			switch(cap) {
				case "delete":
					this.setDelete(state);
					break;
				case "glue":
					this.setGlue(state);
					break;
				case "field":
					this.setField(state);
					break;
			}
		},

		/*
		 * method: setDelete
		 * Set delete button capability for the condition
		 *
		 * @param : state (bool)
		 */
		setDelete: function(state) {
			if (state)
				_sldsEnable(this.delButton, true);
			else
				_sldsEnable(this.delButton, false);
		},

		/*
		 * method: setGlue
		 * Set capability to glue to previous condition
		 *
		 * @param : state (bool)
		 */
		setGlue: function(state) {
			if (state) {
				_sldsEnable(this.glueInput, true);
				this.glueCombo = new ldsCombobox(this.glueBox, {"onSelect" : false});
				window.Comboboxes.push(this.glueCombo);
			} else {
				_sldsEnable(this.glueInput, false);
			}
		},

		/*
		 * method: setField
		 * Set capability to select a field
		 *
		 * @param : state (bool)
		 */
		setField: function(state) {
			if (state) {
				this.fieldCombo = new ldsCombobox(this.fieldBox, {"onSelect" : this.react.bind(this)});
				window.Comboboxes.push(this.fieldCombo);
			}
		},

		/*
		 * method: react
		 * General method used when anything about the condition changes, either selection
		 * of a field or selection of an operation
		 *
		 * @param : value of the combo
		 */
		react: function(val) {
			switch (this.constructor.name) {
				case "Cond":
					this.setOps(val);
					this.setVals();
					break;
				case "Operations":
					// 'this' is bound to the operation instance here
					this.onSelect();
					this.cond.setVals();
					break;
			}
		},

		/*
		 * method: setOps
		 * Responds to the field selector, when a selection is made the operations
		 * combo should update with the appropriate values for the selected field
		 *
		 * @param : val (string)
		 */
		setOps: function(val) {
			this.op   = new Operations(this);
			
			var fieldType = Field.getType(val);
			this.op.getComboBox(fieldType);
			this.replOps();
		},

		/*
		 * method: replOps
		 * Inserts the operations combo in the wrapper DIV and
		 * removes the current content of the operations wrapper
		 *
		 */
		replOps: function(val) {
			this.opWrapper.innerHTML = "";
			this.opWrapper.appendChild(this.op.combo.el);
		},

		/*
		 * method: isFirst
		 * Is this the first condition in the group?
		 *
		 * @return : bool
		 */
		isFirst: function() {
			return this.el.isSameNode(this.group.el.getElementsByClassName(this.class)[0]);
		},

	};

	/* Operations submodule */
	function Operations(cond) {
		this.cond  = cond,
		this.combo = null;
	}

	Operations.prototype = {
		constructor : Operations,
		theseNeedTwo : ["bw"],

		/*
		 * method: getComboBox
		 * Get a new operations ComboBox object based on the field type
		 *
		 * @param  : type of field (typeofdata) (string)
		 * @return : ldsCombobox object
		 */
		getComboBox : function(type) {
			var boxNode  = this.getTempl("box"),
				listNode = boxNode.getElementsByClassName("slds-listbox")[0],
				ops      = this.getOps(type),
				box      = null;

			for (op in ops) {
				listNode.appendChild(this.buildItemNode(op, ops[op]));
			}
			box = new ldsCombobox(boxNode, {"onSelect" : this.cond.react.bind(this)});
			window.Comboboxes.push(box);
			this.combo = box;
		},

		/*
		 * method: onSelect
		 * onselect method for the operations combo
		 *
		 * @param  : value returned from the ldsCombobox instance
		 */
		onSelect : function(val) {
			console.log(val);
		},

		/*
		 * method: buildItemNode
		 * Build an item node, provided an operations object
		 *
		 * @param  : operations value
		 * @param  : operations label
		 * @return : node
		 */
		buildItemNode : function(val,label) {
			var item = this.getTempl("item"),
				span = item.getElementsByClassName("slds-truncate")[0];
			item.setAttribute("data-value", val);
			span.title = span.innerHTML = label;
			return item;
		},

		/*
		 * method: getOps
		 * Get an array of operations by using the field type
		 *
		 * @return : node
		 */
		getOps : function(type) {
			var ops = {};
			for (var i = 0; i < typesofdata[type].length; i++) {
				ops[typesofdata[type][i]] = fLabels[typesofdata[type][i]];
			}
			return ops;
		},

		/*
		 * method: getTempl
		 * Get a new operations template node
		 *
		 * @param  : type of template (box / item) (string)
		 * @return : either combo no (no items inside) of item node
		 */
		getTempl : function(type) {
			var templ   = document.getElementById("cbds-advfilt-template__operation-" + type).children[0],
				newNode = templ.cloneNode(true);
			return newNode;
		},

		/*
		 * method: needsTwoVals
		 * Does this operation require two values?
		 *
		 * @param  : type of operator (string)
		 * @return : bool
		 */
		needsTwoVals : function(type) {
			if (this.theseNeedTwo.indexOf(type) > -1)
				return true;
			else
				return false;
		},

	};

	/* Field submodule */
	function Field() {

	}

	/*
	 * Static method: getType
	 * Deduces the field type from a value
	 *
	 * @param : fieldvalue (string)
	 * @return: typeofdata (string)
	 */
	Field.getType = function(val) {
		var valArray = val.split(":");
		return valArray[valArray.length - 1];
	}

	/* Value submodule */
	function Value(cond, node) {
		this.cond       = cond,
		this.val        = null,
		this.el         = node,
		this.dpActive   = false,
		this.input      = this.el.getElementsByClassName(this.inputClass)[0],
		this.dateButt   = this.el.getElementsByClassName(this.dateButtClass)[0];
	}

	Value.prototype = {
		constructor : Value,

		inputClass : "cbds-advfilt-cond__value--input",
		dateButtClass : "cbds-advfilt-cond__value--datebutt",

		/*
		 * method : setup
		 * Setup the value according to its requirements
		 *
		 * @param : current field type of the condition (string)
		 * @param : current operation type of the condition (string)
		 */
		setup : function(fieldType, opType) {
			switch(fieldType) {
				case "D":
					this.setCap("datepick", true);
					break;
				case "DT":
					this.setCap("datetimepick", true);
					break;
				default:
					this.setCap("datepick", false);
					break;
			}

			var needsTwo = this.cond.op.needsTwoVals(opType);
			if (needsTwo && this.isSecond()) {
				_sldsShow(this.el, true);
			} else if (!needsTwo && this.isSecond()) {
				_sldsShow(this.el, false);
			}
		},

		/*
		 * method : isSecond
		 * Is this the second value box?
		 *
		 * @return : (bool)
		 */
		isSecond : function() {
			return this.el.isSameNode(this.cond.vals[1].el);
		},

		/*
		 * method : setCap
		 * enable or diable a capability for this value
		 *
		 * @param : capability name (string)
		 * @param : capability state (bool)
		 */
		setCap : function(name, state) {
			switch(name) {
				case "datepick":
					this.setDTPick("date", state);
					break;
				case "datetimepick":
					this.setDTPick("datetime", state);
					break;
			}
		},

		/*
		 * method : setDTPick
		 * set the state and type of the date / datetimepicker for this value
		 *
		 * @param : type of picker (date/datetime) (string)
		 * @param : state (bool)
		 */
		setDTPick : function(name, state) {
			var needsTime  = name == "datetime" ? true : false,
			    dateFormat = this.getDateFormat(needsTime);

			Calendar.setup ({
				inputField : this.input,
				ifFormat : dateFormat,
				showsTime : needsTime,
				button : this.dateButt,
				singleClick : true,
				step : 1
			});

			_sldsEnable(this.dateButt, state);
		},

		/*
		 * method: getDateFormat
		 * Gets a correctly formatted date string for the datepicker
		 * based on the current user settings
		 *
		 * @param : include the time format in the string? (bool)
		 */
		getDateFormat: function(needsTime) {
			var dateFormat;
			switch (window.userDateFormat) {
				case "yyyy-mm-dd":
					dateFormat = "%Y-%m-%d";
					break;
				case "dd-mm-yyyy":
					dateFormat = "%d-%m-%Y";
					break;
				case "mm-dd-yyyy":
					dateFormat = "%m-%d-%Y";
					break;
				default:
					dateFormat = "%d-%m-%Y";
			}
			if (needsTime)
				dateFormat += " %H:%M";

			return dateFormat;
		}
	};

	/**
	  * Section with factory tools
	  */
	function _on(el,type,func,context) {
		el.addEventListener(type, func.bind(context));
	}

	function _findUp(element, searchterm) {
		element = element.children[0] != undefined ? element.children[0] : element; // Include the current element
		while (element = element.parentElement) {
			if ( (searchterm.charAt(0) === "#" && element.id === searchterm.slice(1) )
				|| ( searchterm.charAt(0) === "." && element.classList.contains(searchterm.slice(1) ) 
				|| ( searchterm.charAt(0) === "$" && element.tagName === searchterm.slice(1) ) 
				|| ( element.hasAttribute(searchterm) ))) {
				return element;
			} else if (element == document.body) {
				break;
			}
		}
	}

	function _initCombos(parent, targetClass) {
		var combos = parent.getElementsByClassName(targetClass);
		for (var i = combos.length - 1; i >= 0; i--) {
			window.Comboboxes.push(new ldsCombobox(combos[i], {
				"onSelect" : false
			}));
		}
	}

	function _sldsShow(el, state) {
		if (state) {
			el.classList.add("slds-show");
			el.classList.remove("slds-hide");
		} else {
			el.classList.add("slds-hide");
			el.classList.remove("slds-show");
		}
	}

	function _sldsEnable(el, state) {
		if (state)
			el.removeAttribute("disabled");
		else
			el.setAttribute("disabled", "disabled");
	}

	var typesofdata = new Array();
		typesofdata['V'] = ['e', 'n', 's', 'ew', 'dnsw', 'dnew', 'c', 'k'];
		typesofdata['N'] = ['e', 'n', 'l', 'g', 'm', 'h'];
		typesofdata['T'] = ['e', 'n', 'l', 'g', 'm', 'h', 'bw', 'b', 'a'];
		typesofdata['I'] = ['e', 'n', 'l', 'g', 'm', 'h'];
		typesofdata['C'] = ['e', 'n'];
		typesofdata['D'] = ['e', 'n', 'l', 'g', 'm', 'h', 'bw', 'b', 'a'];
		typesofdata['DT'] = ['e', 'n', 'l', 'g', 'm', 'h', 'bw', 'b', 'a'];
		typesofdata['NN'] = ['e', 'n', 'l', 'g', 'm', 'h'];
		typesofdata['E'] = ['e', 'n', 's', 'ew', 'dnsw', 'dnew', 'c', 'k'];

	var fLabels = new Array();
		fLabels['e'] = alert_arr.EQUALS;
		fLabels['n'] = alert_arr.NOT_EQUALS_TO;
		fLabels['s'] = alert_arr.STARTS_WITH;
		fLabels['ew'] = alert_arr.ENDS_WITH;
		fLabels['dnsw'] = alert_arr.DOES_NOT_START_WITH;
		fLabels['dnew'] = alert_arr.DOES_NOT_END_WITH;
		fLabels['c'] = alert_arr.CONTAINS;
		fLabels['k'] = alert_arr.DOES_NOT_CONTAINS;
		fLabels['l'] = alert_arr.LESS_THAN;
		fLabels['g'] = alert_arr.GREATER_THAN;
		fLabels['m'] = alert_arr.LESS_OR_EQUALS;
		fLabels['h'] = alert_arr.GREATER_OR_EQUALS;
		fLabels['bw'] = alert_arr.BETWEEN;
		fLabels['b'] = alert_arr.BEFORE;
		fLabels['a'] = alert_arr.AFTER;	

	/*
	 * Globals
	 */


	return cbAdvancedFilter;

});
