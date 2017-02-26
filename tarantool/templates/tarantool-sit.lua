-- tarantool init script

print('Create configuration example-portfolio-api')

-- requirements
local console = require('console')
ffi = require('ffi')

-- define python None valus
None = ffi.new("void*", nil)
function is(value)
    return value and value ~= None
end

-- start admin console
console.listen('0.0.0.0:{{ environments['portfolio_sit'].console_port }}')

tarantool_user = '{{ environments['portfolio_sit'].user }}'
tarantool_password = '{{ environments['portfolio_sit'].password }}'
tarantool_port = '{{ environments['portfolio_sit'].port }}'

-- tarantool_box configuration
box.cfg {
    slab_alloc_arena = 0.1,
    listen = tarantool_port,
    snapshot_period = 3600,
    snapshot_count = 10,
    vinyl_dir = "/var/lib/tarantool"
}

-- PORTFOLIOS
-- create schema
portfolios = box.space.portfolios
if not portfolios then
    portfolios = box.schema.space.create('portfolios', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - id

-- primary key
if not portfolios.index.primary then
    portfolios:create_index('primary', { parts = { 1, 'unsigned' } })
end


-- SCHEMES
-- create schema
schemes = box.space.schemes
if not schemes then
    schemes = box.schema.space.create('schemes', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - portfolio_id
-- 2 string - scheme_id

-- primary key
if not schemes.index.primary then
    schemes:create_index('primary', { parts = { 1, 'unsigned', 2, 'string' } })
end


-- BOOKS
-- create schema
books = box.space.books
if not books then
    books = box.schema.space.create('books', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - portfolio_id
-- 2 string - scheme_id
-- 3 string - book_id

-- primary key
if not books.index.primary then
    books:create_index('primary', { parts = { 1, 'unsigned', 2, 'string', 3, 'string' } })
end


-- ACCOUNTS
-- create schema
accounts = box.space.accounts
if not accounts then
    accounts = box.schema.space.create('accounts', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - portfolio
-- 2 string - scheme
-- 3 string - book
-- 4 string - id

-- primary key
if not accounts.index.primary then
    accounts:create_index('primary', { parts = { 1, 'unsigned', 2, 'string', 3, 'string', 4, 'string' } })
end


-- ACCOUNTS VALUES
-- create schema
accounts_values = box.space.accounts_values
if not accounts_values then
    accounts_values = box.schema.space.create('accounts_values', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - portfolio
-- 2 string - scheme
-- 3 string - book
-- 4 string - account
-- 5 string - date

-- primary key
if not accounts_values.index.primary then
    accounts_values:create_index('primary', { parts = { 1, 'unsigned', 2, 'string', 3, 'string', 4, 'string', 5, 'string' } })
end


-- POSTINGS
-- create schema
postings = box.space.postings
if not postings then
    postings = box.schema.space.create('postings', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - id
-- 2 unsigned - portfolio
-- 3 string - scheme
-- 4 string - book

-- primary key
if not postings.index.primary then
    postings:create_index('primary', { parts = { 2, 'unsigned', 3, 'string', 4, 'string', 1, 'unsigned' } })
end
-- id key
if not postings.index.id then
    postings:create_index('id', { parts = { 1, 'unsigned', 2, 'unsigned', 3, 'string', 4, 'string' } })
end


-- TRANSACTIONS
-- create schema
transactions = box.space.transactions
if not transactions then
    transactions = box.schema.space.create('transactions', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - id
-- 2 unsigned - portfolio
-- 3 string - effective_date
-- 4 string - isin
-- 5 string - type


-- primary key
if not transactions.index.primary then
    transactions:create_index('primary', { parts = { 2, 'unsigned', 1, 'unsigned', 3, 'string', 4, 'string', 5, 'string' } })
end
-- id key
if not transactions.index.id then
    transactions:create_index('id', { parts = { 1, 'unsigned', 2, 'unsigned', 3, 'string', 4, 'string', 5, 'string' } })
end
-- effective_date key
if not transactions.index.effective_date then
    transactions:create_index('effective_date', { unique = false, parts = { 2, 'unsigned', 3, 'string' } })
end
-- isin key
if not transactions.index.isin then
    transactions:create_index('isin', { unique = false, parts = { 2, 'unsigned', 4, 'string' } })
end
-- type key
if not transactions.index.type then
    transactions:create_index('type', { unique = false, parts = { 2, 'unsigned', 5, 'string' } })
end


-- STATUSES
-- create schema
statuses = box.space.statuses
if not statuses then
    statuses = box.schema.space.create('statuses', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - portfolio_id

-- primary key
if not statuses.index.primary then
    statuses:create_index('primary', { parts = { 1, 'unsigned' } })
end


-- COUNTERS
-- create schema
counters = box.space.counters
if not counters then
    counters = box.schema.space.create('counters', { engine = 'vinyl' })
end

-- create indexes
-- key:
-- 1 unsigned - portfolio_id

-- primary key
if not counters.index.primary then
    counters:create_index('primary', { parts = { 1, 'unsigned' } })
end


-- PERMISSIONS
if not box.schema.user.exists(tarantool_user) then
    box.schema.user.create(tarantool_user, { password = tarantool_password })
    box.schema.user.grant(tarantool_user, 'read,write,execute', 'universe')
end


-- auto_increment bug workaround
portfolios_ai = box.schema.space.create('portfolios_ai', { temporary = true, if_not_exists = true })
portfolios_ai:create_index('primary', { parts = { 1, 'unsigned' }, if_not_exists = true })
portfolios_max = portfolios.index.primary:max()
if portfolios_max then
    portfolios_ai:replace({ portfolios_max[1] })
end

transactions_ai = box.schema.space.create('transactions_ai', { temporary = true, if_not_exists = true })
transactions_ai:create_index('primary', { parts = { 1, 'unsigned' }, if_not_exists = true })
transactions_max = transactions.index.primary:max()
if transactions_max then
    transactions_ai:replace({ transactions_max[1] })
end

postings_ai = box.schema.space.create('postings_ai', { temporary = true, if_not_exists = true })
postings_ai:create_index('primary', { parts = { 1, 'unsigned' }, if_not_exists = true })
postings_max = postings.index.primary:max()
if postings_max then
    postings_ai:replace({ postings_max[1] })
end


-- QUEUE
queue = require 'queue'
recalc = queue.tube.recalc
if not recalc then
    recalc = queue.create_tube('recalc', 'fifo')
end
