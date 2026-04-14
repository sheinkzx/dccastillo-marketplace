# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_14_012438) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "compras", force: :cascade do |t|
    t.bigint "cliente_id", null: false
    t.datetime "created_at", null: false
    t.string "estado", default: "pendiente"
    t.date "fecha"
    t.bigint "producto_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "vendedor_id", null: false
    t.index ["cliente_id"], name: "index_compras_on_cliente_id"
    t.index ["producto_id"], name: "index_compras_on_producto_id"
    t.index ["vendedor_id"], name: "index_compras_on_vendedor_id"
  end

  create_table "productos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "descripcion"
    t.date "fecha"
    t.string "marca"
    t.decimal "precio"
    t.integer "stock"
    t.string "titulo"
    t.datetime "updated_at", null: false
    t.bigint "vendedor_id", null: false
    t.index ["vendedor_id"], name: "index_productos_on_vendedor_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "nombre"
    t.string "password_digest"
    t.string "type"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "compras", "productos"
  add_foreign_key "compras", "users", column: "cliente_id"
  add_foreign_key "compras", "users", column: "vendedor_id"
  add_foreign_key "productos", "users", column: "vendedor_id"
end
