const express = require('express');
const multer = require('multer');
const mysql = require('mysql2');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');
const path = require('path');
const fs = require('fs'); // Import file system module
const xlsx = require('xlsx');
const moment = require('moment');  // Moment.js for handling dates

const app = express();

// Middleware
app.use(express.json());
app.use(cors());
app.use('/uploads', express.static('uploads')); // Serve logo images
app.use(express.urlencoded({ extended: true }));

//----------------------MySQL connection-----------------------------//
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'earist_sis',
});

db.connect(err => {
    if (err) throw err;
    console.log('MySQL Connected...');
});
//----------------------MySQL connection----------------------------//

//----------------Settings-----------------------------------//

// File upload config
const storage = multer.diskStorage({
    destination: './uploads/',
    filename: (req, file, cb) => {
        cb(null, Date.now() + path.extname(file.originalname));
    },
});
// Multer setup for file uploads
const upload = multer({ storage });

// Get company settings
app.get('/api/settings', (req, res) => {
    db.query('SELECT * FROM company_settings WHERE id = 1', (err, result) => {
        if (err) throw err;
        res.send(result[0]);
    });
});

// Helper function to delete old logo
const deleteOldLogo = (logoUrl) => {
    if (!logoUrl) return; // If no logo URL, exit early

    const logoPath = path.join(__dirname, logoUrl); // Construct the full path to the logo file
    fs.unlink(logoPath, (err) => {
        if (err) {
            console.error(`Error deleting old logo at ${logoPath}: ${err}`);
        } else {
            console.log(`Previous logo at ${logoPath} deleted successfully.`);
        }
    });
};

// Update company settings
app.post('/api/settings', upload.single('logo'), (req, res) => {
    const companyName = req.body.company_name || '';
    const headerColor = req.body.header_color || '#ffffff';
    const footerText = req.body.footer_text || '';
    const footerColor = req.body.footer_color || '#ffffff';
    const logoUrl = req.file ? `/uploads/${req.file.filename}` : null;

    // Check if company settings already exist
    db.query('SELECT * FROM company_settings WHERE id = 1', (err, result) => {
        if (err) throw err;

        if (result.length > 0) {
            // Existing settings found

            const oldLogoUrl = result[0].logo_url; // Save old logo URL for deletion

            // Update existing settings
            const query = 'UPDATE company_settings SET company_name = ?, header_color = ?, footer_text = ?, footer_color = ?' +
                (logoUrl ? ', logo_url = ?' : '') + ' WHERE id = 1';
            const params = [companyName, headerColor, footerText, footerColor];
            if (logoUrl) params.push(logoUrl);

            db.query(query, params, (err) => {
                if (err) throw err;

                // If there's a new logo, delete the old one
                if (logoUrl && oldLogoUrl) {
                    deleteOldLogo(oldLogoUrl);
                }

                res.send({ success: true });
            });
        } else {
            // Insert new settings
            const query = 'INSERT INTO company_settings (company_name, header_color, footer_text, footer_color, logo_url) VALUES (?, ?, ?, ?, ?)';
            db.query(query, [companyName, headerColor, footerText, footerColor, logoUrl], (err) => {
                if (err) throw err;
                res.send({ success: true });
            });
        }
    });
});

//-------------------------end settings-----------------------------//

//------------------------Register-------------------------------//
app.post('/register', async (req, res) => {
    const { username, email, password } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const query = `INSERT INTO users (username, email, password) VALUES (?,?,?)`;
    db.query(query, [username, email, hashedPassword], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(200).send({ message: 'User Registered' });
    });
});
//-------------------------Register------------------------------//

//--------------------------Login-----------------------------//
app.post('/login', (req, res) => {
    const { email, password } = req.body;

    const query = `SELECT * FROM users WHERE email = ?`;
    db.query(query, [email], async (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.length === 0) return res.status(400).send({ message: 'User not found' });

        const user = result[0];
        const isMatch = await bcrypt.compare(password, user.password);

        if (!isMatch) return res.status(400).send({ message: 'Invalid Credentials' });

        const token = jwt.sign({ id: user.id }, 'secret', { expiresIn: '1h' });
        res.status(200).send({ token, user: { username: user.username, email: user.email } });
    });
});
//---------------------------Login----------------------------//

//----------------------subject_table-------------------------------//

// Fetch all subjects
app.get('/subject_table', (req, res) => {
    const query = 'SELECT * FROM subject_table';
    db.query(query, (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        res.status(200).json(result);
    });
});

// Create (Add New Subject)
app.post('/subject_table', (req, res) => {
    const { subject_code, subject_description, subject_unit } = req.body;

    // Basic validation
    if (!subject_code || !subject_description || subject_unit == null) {
        return res.status(400).json({ message: 'subject_code, subject_description, and subject_unit are required' });
    }

    const query = 'INSERT INTO subject_table (subject_code, subject_description, subject_unit) VALUES (?, ?, ?)';
    db.query(query, [subject_code, subject_description, subject_unit], (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        res.status(201).json({ message: 'Subject created', id: result.insertId });
    });
});

// Update Subject
app.put('/subject_table/:id', (req, res) => {
    const { subject_code, subject_description, subject_unit } = req.body;
    const { id } = req.params;

    // Basic validation
    if (!subject_code || !subject_description || subject_unit == null) {
        return res.status(400).json({ message: 'subject_code, subject_description, and subject_unit are required' });
    }

    const query = 'UPDATE subject_table SET subject_code = ?, subject_description = ?, subject_unit = ? WHERE id = ?';
    db.query(query, [subject_code, subject_description, subject_unit, id], (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Subject not found' });
        }
        res.status(200).json({ message: 'Subject updated' });
    });
});

// Delete Subject
app.delete('/subject_table/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM subject_table WHERE id = ?';
    db.query(query, [id], (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Subject not found' });
        }
        res.status(200).json({ message: 'Subject deleted' });
    });
});

//---------------------excel - subject_table-----------------------//

// Route to handle XLS file upload for subject_table
app.post('/upload-subjects', upload.single('file'), async (req, res) => {
    if (!req.file) {
        return res.status(400).json({ error: 'No file uploaded' });
    }

    try {
        // Read the uploaded XLS file
        const workbook = xlsx.readFile(req.file.path);
        const sheet_name = workbook.SheetNames[0];
        const sheet = xlsx.utils.sheet_to_json(workbook.Sheets[sheet_name]);

        // Log the uploaded data for troubleshooting
        console.log('Uploaded subject data:', sheet);

        // Array to hold insert promises
        const insertPromises = sheet.map(row => {
            const subjectCode = row.subject_code;
            const subjectDescription = row.subject_description;
            const subjectUnit = row.subject_unit;

            // Validate row data
            if (!subjectCode || !subjectDescription || subjectUnit == null) { // subjectUnit should not be null
                console.error('Invalid row data:', row);
                return Promise.reject(new Error('Invalid row data: ' + JSON.stringify(row)));
            }

            // Insert into subject_table
            return new Promise((resolve, reject) => {
                const query = 'INSERT INTO subject_table (subject_code, subject_description, subject_unit) VALUES (?, ?, ?)';
                db.query(query, [subjectCode, subjectDescription, subjectUnit], (err, result) => {
                    if (err) {
                        console.error('Error inserting subject:', err);
                        return reject(err);
                    }
                    resolve(result);
                });
            });
        });

        // Execute all insertions
        await Promise.all(insertPromises);

        // Respond with success
        res.json({ message: 'Subjects uploaded successfully' });
    } catch (error) {
        console.error('Error processing file:', error);
        res.status(500).json({ error: 'Error processing file' });
    } finally {
        // Clean up uploaded file
        fs.unlink(req.file.path, (err) => {
            if (err) {
                console.error('Error deleting uploaded file:', err);
            }
        });
    }
});

//---------------------subject_quota--------------------------//

// Fetch all subject quotas
app.get('/subject_quota', (req, res) => {
    const query = 'SELECT * FROM subject_quota';
    db.query(query, (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        res.status(200).json(result);
    });
});

// Create (Add New Subject Quota)
app.post('/subject_quota', (req, res) => {
    const { department_section_id, subject_id, quota } = req.body;

    // Basic validation
    if (!department_section_id || !subject_id || quota == null) {
        return res.status(400).json({ message: 'department_section_id, subject_id, and quota are required' });
    }

    const query = 'INSERT INTO subject_quota (department_section_id, subject_id, quota) VALUES (?, ?, ?)';
    db.query(query, [department_section_id, subject_id, quota], (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        res.status(201).json({ message: 'Subject quota created', id: result.insertId });
    });
});

// Update Subject Quota
app.put('/subject_quota/:id', (req, res) => {
    const { department_section_id, subject_id, quota } = req.body;
    const { id } = req.params;

    // Basic validation
    if (!department_section_id || !subject_id || quota == null) {
        return res.status(400).json({ message: 'department_section_id, subject_id, and quota are required' });
    }

    const query = 'UPDATE subject_quota SET department_section_id = ?, subject_id = ?, quota = ? WHERE id = ?';
    db.query(query, [department_section_id, subject_id, quota, id], (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Subject quota not found' });
        }
        res.status(200).json({ message: 'Subject quota updated' });
    });
});

// Delete Subject Quota
app.delete('/subject_quota/:id', (req, res) => {
    const { id } = req.params;
    const query = 'DELETE FROM subject_quota WHERE id = ?';
    db.query(query, [id], (err, result) => {
        if (err) {
            console.error(err); // Log error for debugging
            return res.status(500).json({ message: 'Internal Server Error' });
        }
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'Subject quota not found' });
        }
        res.status(200).json({ message: 'Subject quota deleted' });
    });
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
