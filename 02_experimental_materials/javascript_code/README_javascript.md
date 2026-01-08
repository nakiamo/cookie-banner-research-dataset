# JavaScript Code Documentation

**Purpose:** This document explains the JavaScript code used for data collection in the experimental study.

---

## Overview

The experiment uses three main JavaScript components:

1. **Website Tracking** (`website_tracking.js`) - Embedded in website prototypes
2. **Qualtrics Integration** (`qualtrics_integration.js`) - Embedded in Qualtrics survey
3. **Memory Task** (`memory_task.js`) - Cognitive load manipulation task

---

## 1. Website Tracking (`website_tracking.js`)

### Purpose
Tracks user interactions with the cookie consent banner and sends data to Qualtrics.

### Location
Embedded in all website prototypes (`index.html` files).

### Key Functions

#### Mobile Menu Functionality
- Handles responsive navigation menu
- Toggles menu visibility on mobile devices
- Includes keyboard accessibility support

#### Cookie Consent Tracking
- **Time Tracking:** Records time from page load to first click on cookie banner
- **Choice Recording:** Captures user's cookie consent decision (Accept, Reject, Manage Preferences)
- **Data Transmission:** Sends data to Qualtrics via multiple methods for reliability

### Data Collected

1. **Cookie Choice:**
   - "Accept" - User clicked "Accept All"
   - "Reject" - User clicked "Reject All"
   - "Manage Preferences" - User customized cookie preferences
   - Preference details (if Manage was selected)

2. **Time to First Click:**
   - Time in milliseconds from page load to first interaction with cookie banner
   - Recorded only once (first click)

### Data Transmission Methods

The script uses three methods to ensure reliable data transmission:

1. **postMessage API** (Primary):
   - Sends data from website iframe to parent Qualtrics window
   - Uses origin checking for security
   - Format: `{action: 'setCookieChoice', choice: 'Accept'}`

2. **URL Parameters** (Backup):
   - Updates URL with choice parameter
   - Qualtrics periodically checks URL for updates

3. **Local Storage** (Backup):
   - Stores choice in browser's local storage
   - Can be retrieved if other methods fail

### Integration with Qualtrics

The website is embedded as an iframe in Qualtrics. The script communicates with the parent window using the `postMessage` API:

```javascript
window.parent.postMessage({
    action: 'setCookieChoice',
    choice: 'Accept'
}, ALLOWED_ORIGIN);
```

---

## 2. Qualtrics Integration (`qualtrics_integration.js`)

### Purpose
Receives data from the website iframe and stores it in Qualtrics embedded data fields.

### Location
Embedded in Qualtrics survey question that contains the website iframe.

### Key Functions

#### Message Listener
- Listens for `postMessage` events from the website iframe
- Handles two types of messages:
  1. Cookie choice (`setCookieChoice`)
  2. Time to first click (`setTimeToFirstClick`)

#### URL Parameter Checker
- Periodically checks iframe URL for cookie choice parameter
- Updates Qualtrics embedded data if found
- Runs every 1 second as backup method

#### Data Storage
- Stores data in Qualtrics embedded data fields:
  - `CookieChoice` - User's cookie consent decision
  - `TimeToFirstClick` - Time in milliseconds to first click

### Qualtrics Embedded Data Fields

The script creates/updates the following embedded data fields:

- **CookieChoice:** String value ("Accept", "Reject", or preference details)
- **TimeToFirstClick:** Numeric value (milliseconds)

These fields are automatically included in the Qualtrics export and can be accessed in subsequent survey questions.

---

## 3. Memory Task (`memory_task.js`)

### Purpose
Implements the cognitive load manipulation task (memory-based distraction).

### Location
Embedded in Qualtrics survey question before website exposure.

### Task Description

Participants are shown three fictional coffee orders sequentially:
1. **Sezgin:** Grande Karamelli Macchiato
2. **Haluk:** Venti Pumpkin Spice Latte
3. **Emrah:** Tall Mocha Frappuccino

Each order is displayed for 5 seconds with a fade-in/fade-out effect.

### Implementation Details

- Orders are displayed one at a time
- Each order visible for 5 seconds
- Total task duration: ~15 seconds
- Participants can replay the sequence
- "Next" button is enabled throughout (participants proceed when ready)

### Cognitive Load Manipulation

This task creates cognitive load by:
- Requiring participants to remember information
- Creating a distraction before cookie consent decision
- Reducing available cognitive resources for decision-making

**Note:** Participants in the baseline condition (no cognitive load) do not see this task.

---

## Integration Flow

### Complete Data Collection Flow

1. **Memory Task (if applicable):**
   - Participant views coffee orders
   - Task creates cognitive load

2. **Website Exposure:**
   - Website prototype loads in Qualtrics iframe
   - `website_tracking.js` initializes
   - Page load time recorded

3. **Cookie Banner Interaction:**
   - Participant clicks on cookie banner
   - `website_tracking.js` records:
     - Choice (Accept/Reject/Manage)
     - Time to first click
   - Data sent to Qualtrics via `postMessage`

4. **Data Reception:**
   - `qualtrics_integration.js` receives message
   - Data stored in Qualtrics embedded data fields
   - Available for export and analysis

---

## Technical Requirements

### Browser Compatibility
- Modern browsers with JavaScript enabled
- Support for `postMessage` API
- Support for `localStorage` API

### Security
- Origin checking prevents cross-site scripting
- `ALLOWED_ORIGIN` variable ensures messages only from expected source

### Error Handling
- Multiple transmission methods ensure data reliability
- Console logging for debugging
- Graceful degradation if methods fail

---

## Usage Instructions

### For Website Prototypes

1. Include `website_tracking.js` in the `<head>` or before closing `</body>` tag:
```html
<script src="main.js"></script>
```

2. Ensure cookie banner HTML elements have correct IDs:
   - `cookie-consent-banner`
   - `accept-cookies`
   - `reject-cookies`
   - `manage-preferences`
   - `save-preferences`

### For Qualtrics Survey

1. Add `qualtrics_integration.js` to the question containing the website iframe:
   - Go to Question Options → JavaScript
   - Paste the code in the "Add JavaScript" section

2. Configure embedded data fields in Qualtrics:
   - Survey Flow → Add Embedded Data
   - Add fields: `CookieChoice`, `TimeToFirstClick`

3. Add memory task question (if applicable):
   - Create new question
   - Add `memory_task.js` to question JavaScript
   - Place before website exposure question

---

## Data Export

After survey completion, Qualtrics exports include:

- **CookieChoice:** Participant's cookie consent decision
- **TimeToFirstClick:** Time in milliseconds from page load to first click

These variables are automatically included in the CSV export and can be used for analysis.

---

## Troubleshooting

### Data Not Recording

1. **Check browser console** for error messages
2. **Verify iframe embedding** - Website must be in iframe
3. **Check origin settings** - Ensure `ALLOWED_ORIGIN` matches
4. **Verify Qualtrics embedded data** - Fields must be configured

### Time Not Recording

1. **Check if participant clicked banner** - Time only records on first click
2. **Verify JavaScript execution** - Check browser console
3. **Check data transmission** - Look for postMessage logs

### Memory Task Not Displaying

1. **Verify JavaScript is added** to Qualtrics question
2. **Check browser compatibility** - Modern browser required
3. **Verify question container** - Must be valid Qualtrics question

---

## Files

- `website_tracking.js` - Cookie banner interaction tracking
- `qualtrics_integration.js` - Qualtrics data reception
- `memory_task.js` - Cognitive load manipulation task

---

**Last Updated:** 2025-12-29

